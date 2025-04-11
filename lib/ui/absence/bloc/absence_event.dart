import 'package:equatable/equatable.dart';

abstract class AbsencesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAbsences extends AbsencesEvent {}
