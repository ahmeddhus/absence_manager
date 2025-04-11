import 'package:absence_manager/domain/models/absence_with_member.dart';
import 'package:equatable/equatable.dart';

abstract class AbsencesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AbsencesInitial extends AbsencesState {}

class AbsencesLoading extends AbsencesState {}

class AbsencesLoaded extends AbsencesState {
  final List<AbsenceWithMember> absences;

  AbsencesLoaded(this.absences);

  @override
  List<Object?> get props => [absences];
}

class AbsencesError extends AbsencesState {
  final String message;

  AbsencesError(this.message);

  @override
  List<Object?> get props => [message];
}
