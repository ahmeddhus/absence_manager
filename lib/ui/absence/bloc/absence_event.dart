import 'package:equatable/equatable.dart';

abstract class AbsencesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAbsences extends AbsencesEvent {}

class LoadMoreAbsences extends AbsencesEvent {
  final int offset;
  final int limit;

  LoadMoreAbsences({required this.offset, required this.limit});

  @override
  List<Object?> get props => [offset, limit];
}
