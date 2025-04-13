import 'package:absence_manager/domain/models/absence/absence_type.dart';
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
  final AbsenceType? selectedType;
  final DateTimeRange? selectedDateRange;
  final bool isExporting;

  AbsencesLoaded({
    required this.absences,
    required this.hasMore,
    required this.totalCount,
    this.selectedType,
    this.selectedDateRange,
    this.isExporting = false,
  });

  AbsencesLoaded copyWith({
    List<AbsenceWithMember>? absences,
    bool? hasMore,
    int? totalCount,
    AbsenceType? selectedType,
    DateTimeRange? selectedDateRange,
    bool? isExporting,
  }) {
    return AbsencesLoaded(
      absences: absences ?? this.absences,
      hasMore: hasMore ?? this.hasMore,
      totalCount: totalCount ?? this.totalCount,
      selectedType: selectedType ?? this.selectedType,
      selectedDateRange: selectedDateRange ?? this.selectedDateRange,
      isExporting: isExporting ?? this.isExporting,
    );
  }

  @override
  List<Object?> get props => [
    absences,
    hasMore,
    totalCount,
    selectedType,
    selectedDateRange,
    isExporting,
  ];
}

class AbsencesError extends AbsencesState {
  final String message;

  AbsencesError(this.message);

  @override
  List<Object?> get props => [message];
}
