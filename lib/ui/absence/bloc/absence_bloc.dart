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
    on<LoadMoreAbsences>(_onLoadMoreAbsences);
    on<ExportAbsencesToICal>(_onExportAbsencesToICal);
  }

  Future<void> _onLoadAbsences(LoadAbsences event, Emitter<AbsencesState> emit) async {
    final currentState = state;

    _selectedType = event.type;
    _selectedDateRange = event.dateRange;

    if (currentState is AbsencesLoaded) {
      emit(
        currentState.copyWith(
          isInitialLoading: true,
          selectedType: _selectedType,
          selectedDateRange: _selectedDateRange,
        ),
      );
    } else {
      emit(
        AbsencesLoaded.initial(selectedType: _selectedType, selectedDateRange: _selectedDateRange),
      );
    }

    final result = await getAbsencesWithMembers(
      offset: 0,
      limit: 10,
      type: _selectedType?.name,
      dateRange: _selectedDateRange,
    );

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

  Future<void> _onLoadMoreAbsences(LoadMoreAbsences event, Emitter<AbsencesState> emit) async {
    final currentState = state;

    if (currentState is AbsencesLoaded) {
      emit(currentState.copyWith(isLoadingMore: true));

      final result = await getAbsencesWithMembers(
        offset: event.offset,
        limit: event.limit,
        type: _selectedType?.name,
        dateRange: _selectedDateRange,
      );

      await result.handle(
        onSuccess: (value) async {
          final filteredNew = value.absences;
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
