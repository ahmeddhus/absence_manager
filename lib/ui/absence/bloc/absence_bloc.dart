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
        final absences = await useCase.execute(offset: 0, limit: 10);
        emit(AbsencesLoaded(absences, hasMore: absences.length == 10));
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
          final additionalAbsences = await useCase.execute(
            offset: event.offset,
            limit: event.limit,
          );
          final hasMore = additionalAbsences.length == event.limit;
          emit(AbsencesLoaded(currentState.absences + additionalAbsences, hasMore: hasMore));
        } catch (e) {
          emit(AbsencesError(e.toString()));
        }
      }
    });
  }
}
