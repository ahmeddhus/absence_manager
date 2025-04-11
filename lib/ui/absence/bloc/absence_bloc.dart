import 'package:absence_manager/domain/use_cases/get_absences_with_members_use_case.dart';
import 'package:absence_manager/ui/absence/bloc/absence_event.dart';
import 'package:absence_manager/ui/absence/bloc/absence_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsencesBloc extends Bloc<AbsencesEvent, AbsencesState> {
  final GetAbsencesWithMembersUseCase useCase;

  AbsencesBloc(this.useCase) : super(AbsencesInitial()) {
    // Initial load
    on<LoadAbsences>((event, emit) async {
      emit(AbsencesLoading());
      try {
        final result = await useCase.execute(offset: 0, limit: 10);
        emit(
          AbsencesLoaded(
            absences: result.absences,
            hasMore: result.absences.length == 10,
            totalCount: result.totalCount,
          ),
        );
      } catch (e) {
        emit(AbsencesError(e.toString()));
      }
    });

    // Load more absences
    on<LoadMoreAbsences>((event, emit) async {
      final currentState = state;
      if (currentState is AbsencesLoaded) {
        emit(AbsencesLoadingMore());
        try {
          final result = await useCase.execute(offset: event.offset, limit: event.limit);
          final hasMore = result.absences.length == event.limit;
          emit(
            AbsencesLoaded(
              absences: currentState.absences + result.absences,
              hasMore: hasMore,
              totalCount: result.totalCount,
            ),
          );
        } catch (e) {
          emit(AbsencesError(e.toString()));
        }
      }
    });
  }
}
