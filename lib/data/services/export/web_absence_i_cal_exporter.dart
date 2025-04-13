import 'dart:html' as html;

import 'package:absence_manager/domain/models/absence_with_member.dart';
import 'package:absence_manager/domain/use_cases/absence_i_cal_exporter.dart';
import 'package:absence_manager/util/i_cal_exporter.dart';

/// Web implementation of [AbsenceExporter].
///
/// Uses [AnchorElement] and [Blob] to trigger a browser download of the generated .ics file.

AbsenceICalExporter createAbsenceExporter() => WebAbsenceICalExporter();

class WebAbsenceICalExporter implements AbsenceICalExporter {
  @override
  Future<void> export(List<AbsenceWithMember> absences) async {
    final content = ICalExporter.buildICalContent(absences);
    final blob = html.Blob([content], 'text/calendar');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor =
        html.AnchorElement(href: url)
          ..setAttribute('download', 'absences.ics')
          ..click();
    html.Url.revokeObjectUrl(url);
  }
}
