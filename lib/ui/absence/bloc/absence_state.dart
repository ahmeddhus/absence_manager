import 'package:absence_manager/domain/models/absence_with_member.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
  final int totalCount;
  final String? selectedType;
  final DateTimeRange? selectedDateRange;

  AbsencesLoaded({
    required this.absences,
    required this.hasMore,
    required this.totalCount,
    this.selectedType,
    this.selectedDateRange,
  });

  @override
  List<Object?> get props => [absences, hasMore, totalCount, selectedType, selectedDateRange];
}

class AbsencesError extends AbsencesState {
  final String message;

  AbsencesError(this.message);

  @override
  List<Object?> get props => [message];
}
