import 'package:absence_manager/domain/models/absence_with_member.dart';
import 'package:absence_manager/domain/use_cases/absence_i_cal_exporter.dart';

AbsenceICalExporter createAbsenceExporter() => StubAbsenceICalExporter();

class StubAbsenceICalExporter implements AbsenceICalExporter {
  @override
  Future<void> export(List<AbsenceWithMember> absences) {
    throw UnsupportedError('Platform not supported');
  }
}
