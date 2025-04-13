// This is a pure Dart model intended for the domain layer.
// We intentionally avoid using `freezed` or other code generators here
// to keep the domain layer decoupled from dependencies and tooling,
// as per clean architecture principles.

import 'package:absence_manager/domain/models/absence/absence_type.dart';

class Absence {
  final int? id;
  final int? userId;
  final AbsenceType? type; // 'vacation', 'sickness'
  final DateTime? startDate;
  final DateTime? endDate;
  final String? memberNote;
  final String? admitterNote;
  final AbsenceStatus status;

  Absence({
    required this.id,
    required this.userId,
    required this.type,
    required this.startDate,
    required this.endDate,
    this.memberNote,
    this.admitterNote,
    required this.status,
  });
}

enum AbsenceStatus { requested, confirmed, rejected }
