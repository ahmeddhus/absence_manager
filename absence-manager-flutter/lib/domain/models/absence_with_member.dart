import 'package:absence_manager/domain/models/absence/absence.dart';
import 'package:absence_manager/domain/models/member/member.dart';

/// Combines an [Absence] with its corresponding [Member] information.
///
/// This model exists to support UI requirements that need to display both
/// absence details (e.g. type, period, status) and member details (e.g. name, image).
///
/// The combination happens in the domain layer because it's part of core
/// business logic, not just presentation or storage.

class AbsenceWithMember {
  final Absence absence;
  final Member member;

  AbsenceWithMember({required this.absence, required this.member});
}
