import 'package:absence_manager/domain/use_cases/get_absences_with_members_use_case.dart';
import 'package:absence_manager/ui/absence/bloc/absence_event.dart';
import 'package:absence_manager/ui/absence/bloc/absence_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsencesBloc extends Bloc<AbsencesEvent, AbsencesState> {
  final GetAbsencesWithMembersUseCase useCase;

  AbsencesBloc(this.useCase) : super(AbsencesInitial()) {
    on<LoadAbsences>((event, emit) async {
      emit(AbsencesLoading());
      try {
        final absences = await useCase.execute();
        emit(AbsencesLoaded(absences));
      } catch (e) {
        emit(AbsencesError(e.toString()));
      }
    });
  }
}
