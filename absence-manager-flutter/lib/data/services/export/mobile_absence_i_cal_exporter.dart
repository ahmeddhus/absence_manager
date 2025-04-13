import 'package:absence_manager/domain/models/absence_with_member.dart';
import 'package:absence_manager/domain/use_cases/absence_i_cal_exporter.dart';
import 'package:absence_manager/utils/i_cal_exporter.dart';
import 'package:share_plus/share_plus.dart';

/// Mobile implementation of [AbsenceExporter].
///
/// Generates a local .ics file and shares it using the `share_plus` plugin.

AbsenceICalExporter createAbsenceExporter() => MobileAbsenceICalExporter();

class MobileAbsenceICalExporter implements AbsenceICalExporter {
  @override
  Future<void> export(List<AbsenceWithMember> absences) async {
    final file = await ICalExporter.generateICalFile(absences);
    await Share.shareXFiles([XFile(file.path)]);
  }
}
