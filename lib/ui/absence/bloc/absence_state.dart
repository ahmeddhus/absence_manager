import 'package:absence_manager/domain/models/absence_with_member.dart';
import 'package:equatable/equatable.dart';

abstract class AbsencesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AbsencesInitial extends AbsencesState {}

class AbsencesLoading extends AbsencesState {}

class AbsencesLoadingMore extends AbsencesState {}

class AbsencesLoaded extends AbsencesState {
  final List<AbsenceWithMember> absences;
  final bool hasMore;

  AbsencesLoaded(this.absences, {this.hasMore = false});

  @override
  List<Object?> get props => [absences, hasMore];
}

class AbsencesError extends AbsencesState {
  final String message;

  AbsencesError(this.message);

  @override
  List<Object?> get props => [message];
}
