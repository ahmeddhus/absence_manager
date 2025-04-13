import 'package:absence_manager/domain/models/absence_with_member.dart';

class AbsenceListWithMembers {
  final int totalCount;
  final List<AbsenceWithMember> absences;

  AbsenceListWithMembers({required this.totalCount, required this.absences});
}
