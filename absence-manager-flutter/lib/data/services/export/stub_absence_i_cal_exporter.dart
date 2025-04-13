import 'package:absence_manager/domain/models/absence_with_member.dart';
import 'package:absence_manager/domain/use_cases/absence_i_cal_exporter.dart';

/// Fallback implementation of [AbsenceExporter] for unsupported platforms.
///
/// Throws an [UnsupportedError] with a detailed message when `export()` is called./

AbsenceICalExporter createAbsenceExporter() => StubAbsenceICalExporter();

class StubAbsenceICalExporter implements AbsenceICalExporter {
  @override
  Future<void> export(List<AbsenceWithMember> absences) {
    throw UnsupportedError('Platform not supported');
  }
}
