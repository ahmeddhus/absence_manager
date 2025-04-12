import 'dart:io';

import 'package:absence_manager/domain/models/absence/absence_type.dart';
import 'package:absence_manager/domain/models/absence_with_member.dart';
import 'package:path_provider/path_provider.dart';

class ICalExporter {
  /// Generates an .ics file containing the given [absences]
  /// and saves it in the app's documents directory.
  /// Returns the generated file.
  static Future<File> generateICalFile(List<AbsenceWithMember> absences) async {
    final buffer =
        StringBuffer()
          ..writeln('BEGIN:VCALENDAR')
          ..writeln('VERSION:2.0')
          ..writeln('PRODID:-//Crewmeister Absence Manager//EN');

    for (final entry in absences) {
      final absence = entry.absence;
      final member = entry.member;

      if (absence.startDate == null || absence.endDate == null) continue;

      buffer
        ..writeln('BEGIN:VEVENT')
        ..writeln('UID:${absence.id}-${member.userId}@crewmeister')
        ..writeln('DTSTAMP:${_formatDateTime(DateTime.now())}')
        ..writeln('DTSTART;VALUE=DATE:${_formatDate(absence.startDate!)}')
        ..writeln('DTEND;VALUE=DATE:${_formatDate(absence.endDate!.add(const Duration(days: 1)))}')
        ..writeln('SUMMARY:${member.name} - ${absence.type?.label}')
        ..writeln('STATUS:${absence.status.name.toUpperCase()}');

      if (absence.memberNote?.isNotEmpty ?? false) {
        buffer.writeln('DESCRIPTION:${absence.memberNote}');
      }

      buffer.writeln('END:VEVENT');
    }

    buffer.writeln('END:VCALENDAR');

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/absences_${DateTime.now().millisecondsSinceEpoch}.ics');
    await file.writeAsString(buffer.toString());

    return file;
  }

  /// Formats a date as YYYYMMDD (iCal all-day event format).
  static String _formatDate(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}'
        '${date.month.toString().padLeft(2, '0')}'
        '${date.day.toString().padLeft(2, '0')}';
  }

  /// Formats a timestamp as YYYYMMDDTHHMMSSZ (iCal timestamp format).
  static String _formatDateTime(DateTime dateTime) {
    final utc = dateTime.toUtc();
    return '${_formatDate(utc)}T'
        '${utc.hour.toString().padLeft(2, '0')}'
        '${utc.minute.toString().padLeft(2, '0')}'
        '${utc.second.toString().padLeft(2, '0')}Z';
  }
}
