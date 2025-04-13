import 'package:absence_manager/domain/models/absence/absence_type.dart';
import 'package:absence_manager/domain/models/absence_with_member.dart';
import 'package:absence_manager/domain/use_cases/absence_i_cal_exporter.dart';
import 'package:absence_manager/domain/use_cases/get_absences_with_members_use_case.dart';
import 'package:absence_manager/ui/absence/bloc/absence_event.dart';
import 'package:absence_manager/ui/absence/bloc/absence_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// BLoC responsible for managing the loading, filtering, and pagination of absences.
class AbsencesBloc extends Bloc<AbsencesEvent, AbsencesState> {
  final GetAbsencesWithMembersUseCase useCase;
  final AbsenceICalExporter exporter;

  AbsenceType? _selectedType;
  DateTimeRange? _selectedDateRange;

  AbsencesBloc(this.useCase, this.exporter) : super(AbsencesInitial()) {
    /// Handles initial data load (unfiltered)
    on<LoadAbsences>((event, emit) async {
      emit(AbsencesLoading());
      try {
        final result = await useCase.execute(offset: 0, limit: 10);
        _emitLoaded(
          emit,
          result.absences,
          hasMore: result.absences.length == 10,
          totalCount: result.totalCount,
        );
      } catch (e) {
        emit(AbsencesError(e.toString()));
      }
    });

    /// Handles filtering by type and/or date
    on<FilterAbsences>((event, emit) async {
      emit(AbsencesLoading());

      _selectedType = event.type;
      _selectedDateRange = event.dateRange;

      try {
        final result = await useCase.execute(offset: 0, limit: 100);
        final filtered = result.absences.where(_matchesCurrentFilters).toList();

        _emitLoaded(emit, filtered, hasMore: false, totalCount: result.totalCount);
      } catch (e) {
        emit(AbsencesError(e.toString()));
      }
    });

    /// Handles pagination of data and applies existing filters to newly fetched results
    on<LoadMoreAbsences>((event, emit) async {
      final currentState = state;
      if (currentState is AbsencesLoaded) {
        emit(AbsencesLoadingMore());
        try {
          final result = await useCase.execute(offset: event.offset, limit: event.limit);
          final filteredNew = result.absences.where(_matchesCurrentFilters).toList();
          final combined = currentState.absences + filteredNew;

          _emitLoaded(
            emit,
            combined,
            hasMore: result.absences.length == event.limit,
            totalCount: result.totalCount,
          );
        } catch (e) {
          emit(AbsencesError(e.toString()));
        }
      }
    });

    /// Handles exporting absences to iCal using the injected [AbsenceExporter].
    /// Emits `isExporting: true` while the export is in progress.
    /// On completion, emits `isExporting: false` and triggers [onExportResult] callback.
    on<ExportAbsencesToICal>((event, emit) async {
      final currentState = state;
      if (currentState is AbsencesLoaded) {
        emit(currentState.copyWith(isExporting: true));

        try {
          await exporter.export(currentState.absences);
          emit(currentState.copyWith(isExporting: false));
          event.onExportResult?.call("Data exported successfully");
        } catch (e) {
          emit(currentState.copyWith(isExporting: false));
          event.onExportResult?.call('Export failed: ${e.toString()}');
        }
      }
    });
  }

  /// Reusable method to check if an absence matches the active filters
  bool _matchesCurrentFilters(AbsenceWithMember a) {
    final matchesType = _selectedType == null || a.absence.type == _selectedType;

    final matchesDate =
        _selectedDateRange == null ||
        (a.absence.startDate != null &&
            a.absence.endDate != null &&
            a.absence.startDate!.isAfter(
              _selectedDateRange!.start.subtract(const Duration(days: 1)),
            ) &&
            a.absence.endDate!.isBefore(_selectedDateRange!.end.add(const Duration(days: 1))));

    return matchesType && matchesDate;
  }

  /// Emit AbsencesLoaded state using consistent structure
  void _emitLoaded(
    Emitter<AbsencesState> emit,
    List<AbsenceWithMember> absences, {
    required bool hasMore,
    required int totalCount,
  }) {
    emit(
      AbsencesLoaded(
        absences: absences,
        hasMore: hasMore,
        totalCount: totalCount,
        selectedType: _selectedType,
        selectedDateRange: _selectedDateRange,
      ),
    );
  }
}
