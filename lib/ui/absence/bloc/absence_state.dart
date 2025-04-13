import 'package:absence_manager/domain/models/absence/absence_type.dart';
import 'package:absence_manager/domain/models/absence_with_member.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AbsencesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AbsencesInitial extends AbsencesState {}

class AbsencesLoaded extends AbsencesState {
  final List<AbsenceWithMember> absences;
  final bool hasMore;
  final int totalCount;
  final AbsenceType? selectedType;
  final DateTimeRange? selectedDateRange;
  final bool isInitialLoading; // for initial loading or filter
  final bool isExporting;
  final bool isLoadingMore; // when fetching more at scroll end

  AbsencesLoaded({
    required this.absences,
    required this.hasMore,
    required this.totalCount,
    this.selectedType,
    this.selectedDateRange,
    this.isInitialLoading = false,
    this.isExporting = false,
    this.isLoadingMore = false,
  });

  factory AbsencesLoaded.initial({AbsenceType? selectedType, DateTimeRange? selectedDateRange}) {
    return AbsencesLoaded(
      absences: [],
      hasMore: false,
      totalCount: 0,
      isInitialLoading: true,
      selectedType: selectedType,
      selectedDateRange: selectedDateRange,
    );
  }

  AbsencesLoaded copyWith({
    List<AbsenceWithMember>? absences,
    bool? hasMore,
    int? totalCount,
    AbsenceType? selectedType,
    DateTimeRange? selectedDateRange,
    bool? isInitialLoading,
    bool? isExporting,
    bool? isLoadingMore,
  }) {
    return AbsencesLoaded(
      absences: absences ?? this.absences,
      hasMore: hasMore ?? this.hasMore,
      totalCount: totalCount ?? this.totalCount,
      selectedType: selectedType ?? this.selectedType,
      selectedDateRange: selectedDateRange ?? this.selectedDateRange,
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      isExporting: isExporting ?? this.isExporting,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
    absences,
    hasMore,
    totalCount,
    selectedType,
    selectedDateRange,
    isInitialLoading,
    isExporting,
    isLoadingMore,
  ];
}

class AbsencesError extends AbsencesState {
  final String message;

  AbsencesError(this.message);

  @override
  List<Object?> get props => [message];
}
