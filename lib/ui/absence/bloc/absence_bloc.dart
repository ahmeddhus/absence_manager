import 'package:absence_manager/domain/models/absence/absence_type.dart';
import 'package:absence_manager/domain/use_cases/get_absences_with_members_use_case.dart';
import 'package:absence_manager/ui/absence/bloc/absence_event.dart';
import 'package:absence_manager/ui/absence/bloc/absence_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// BLoC responsible for managing the loading, filtering, and pagination of absences.
class AbsencesBloc extends Bloc<AbsencesEvent, AbsencesState> {
  final GetAbsencesWithMembersUseCase useCase;

  AbsenceType? _selectedType;
  DateTimeRange? _selectedDateRange;

  AbsencesBloc(this.useCase) : super(AbsencesInitial()) {
    // Handles initial data load (unfiltered)
    on<LoadAbsences>((event, emit) async {
      emit(AbsencesLoading());
      try {
        final result = await useCase.execute(offset: 0, limit: 10);
        emit(
          AbsencesLoaded(
            absences: result.absences,
            hasMore: result.absences.length == 10,
            totalCount: result.totalCount,
            selectedType: _selectedType,
            selectedDateRange: _selectedDateRange,
          ),
        );
      } catch (e) {
        emit(AbsencesError(e.toString()));
      }
    });

    // Handles filtering by type and/or date
    on<FilterAbsences>((event, emit) async {
      emit(AbsencesLoading());

      _selectedType = event.type;
      _selectedDateRange = event.dateRange;

      try {
        final result = await useCase.execute(offset: 0, limit: 100);

        // Filters absences: keeps only those that match the selected type (if any)
        // and have both start and end dates within the selected date range (if any)
        final filtered =
            result.absences.where((a) {
              final matchesType = _selectedType == null || a.absence.type == _selectedType;
              final matchesDate =
                  _selectedDateRange == null ||
                  (a.absence.startDate.isAfter(
                        _selectedDateRange!.start.subtract(const Duration(days: 1)),
                      ) &&
                      a.absence.endDate.isBefore(
                        _selectedDateRange!.end.add(const Duration(days: 1)),
                      ));
              return matchesType && matchesDate;
            }).toList();

        emit(
          AbsencesLoaded(
            absences: filtered,
            hasMore: false,
            totalCount: result.totalCount,
            selectedType: _selectedType,
            selectedDateRange: _selectedDateRange,
          ),
        );
      } catch (e) {
        emit(AbsencesError(e.toString()));
      }
    });

    // Handles pagination of data and applies existing filters to newly fetched results
    on<LoadMoreAbsences>((event, emit) async {
      final currentState = state;
      if (currentState is AbsencesLoaded) {
        emit(AbsencesLoadingMore());
        try {
          final result = await useCase.execute(offset: event.offset, limit: event.limit);
          final hasMore = result.absences.length == event.limit;

          // Merge newly fetched absences with existing ones,
          // applying current type and date filters to the new items only
          final combined =
              currentState.absences +
              result.absences.where((a) {
                final matchesType = _selectedType == null || a.absence.type == _selectedType;
                final matchesDate =
                    _selectedDateRange == null ||
                    (a.absence.startDate.isAfter(
                          _selectedDateRange!.start.subtract(const Duration(days: 1)),
                        ) &&
                        a.absence.endDate.isBefore(
                          _selectedDateRange!.end.add(const Duration(days: 1)),
                        ));
                return matchesType && matchesDate;
              }).toList();

          emit(
            AbsencesLoaded(
              absences: combined,
              hasMore: hasMore,
              totalCount: result.totalCount,
              selectedType: _selectedType,
              selectedDateRange: _selectedDateRange,
            ),
          );
        } catch (e) {
          emit(AbsencesError(e.toString()));
        }
      }
    });
  }
}
