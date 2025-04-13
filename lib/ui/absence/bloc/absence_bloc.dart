import 'package:absence_manager/core/result/result_extensions.dart';
import 'package:absence_manager/domain/models/absence/absence_type.dart';
import 'package:absence_manager/domain/models/absence_with_member.dart';
import 'package:absence_manager/domain/use_cases/absence_i_cal_exporter.dart';
import 'package:absence_manager/domain/use_cases/get_absences_with_members_use_case.dart';
import 'package:absence_manager/ui/absence/bloc/absence_event.dart';
import 'package:absence_manager/ui/absence/bloc/absence_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsencesBloc extends Bloc<AbsencesEvent, AbsencesState> {
  final GetAbsencesWithMembersUseCase getAbsencesWithMembers;
  final AbsenceICalExporter exporter;

  AbsenceType? _selectedType;
  DateTimeRange? _selectedDateRange;

  AbsencesBloc(this.getAbsencesWithMembers, this.exporter) : super(AbsencesInitial()) {
    on<LoadAbsences>(_onLoadAbsences);
    on<FilterAbsences>(_onFilterAbsences);
    on<LoadMoreAbsences>(_onLoadMoreAbsences);
    on<ExportAbsencesToICal>(_onExportAbsencesToICal);
  }

  Future<void> _onLoadAbsences(LoadAbsences event, Emitter<AbsencesState> emit) async {
    emit(AbsencesLoading());

    final result = await getAbsencesWithMembers(offset: 0, limit: 10);

    await result.handle(
      onSuccess: (value) async {
        _emitLoaded(
          emit,
          value.absences,
          hasMore: value.absences.length == 10,
          totalCount: value.totalCount,
        );
      },
      onError: (error) async {
        emit(AbsencesError(error.toString()));
      },
    );
  }

  Future<void> _onFilterAbsences(FilterAbsences event, Emitter<AbsencesState> emit) async {
    emit(AbsencesLoading());

    _selectedType = event.type;
    _selectedDateRange = event.dateRange;

    final result = await getAbsencesWithMembers(
      offset: 0,
      limit: 100,
      type: _selectedType?.label.toLowerCase(),
      dateRange: _selectedDateRange,
    );

    await result.handle(
      onSuccess: (value) async {
        final filtered = value.absences.where(_matchesCurrentFilters).toList();
        _emitLoaded(emit, filtered, hasMore: false, totalCount: value.totalCount);
      },
      onError: (error) async {
        emit(AbsencesError(error.toString()));
      },
    );
  }

  Future<void> _onLoadMoreAbsences(LoadMoreAbsences event, Emitter<AbsencesState> emit) async {
    final currentState = state;

    if (currentState is AbsencesLoaded) {
      emit(currentState.copyWith(isLoadingMore: true));

      final result = await getAbsencesWithMembers(offset: event.offset, limit: event.limit);

      await result.handle(
        onSuccess: (value) async {
          final filteredNew = value.absences.where(_matchesCurrentFilters).toList();
          final combined = currentState.absences + filteredNew;

          _emitLoaded(
            emit,
            combined,
            hasMore: value.absences.length == event.limit,
            totalCount: value.totalCount,
          );
        },
        onError: (error) async {
          emit(AbsencesError(error.toString()));
        },
      );
    }
  }

  Future<void> _onExportAbsencesToICal(
    ExportAbsencesToICal event,
    Emitter<AbsencesState> emit,
  ) async {
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
  }

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
