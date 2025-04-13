import 'package:absence_manager/domain/models/absence/absence_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AbsencesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAbsences extends AbsencesEvent {
  final AbsenceType? type; // e.g., 'vacation', 'sickness'
  final DateTimeRange? dateRange;

  LoadAbsences({this.type, this.dateRange});

  @override
  List<Object?> get props => [type, dateRange];
}

class LoadMoreAbsences extends AbsencesEvent {
  final int offset;
  final int limit;

  LoadMoreAbsences({required this.offset, required this.limit});

  @override
  List<Object?> get props => [offset, limit];
}

class ExportAbsencesToICal extends AbsencesEvent {
  final void Function(String message)? onExportResult;

  ExportAbsencesToICal({this.onExportResult});

  @override
  List<Object?> get props => [];
}
