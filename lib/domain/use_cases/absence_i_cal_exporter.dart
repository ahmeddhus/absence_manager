import 'package:absence_manager/domain/models/absence_with_member.dart';

abstract class AbsenceICalExporter {
  Future<void> export(List<AbsenceWithMember> absences);
}
