import 'dart:io';

import 'package:absence_manager/domain/models/absence/absence_type.dart';
import 'package:absence_manager/domain/models/absence_with_member.dart';
import 'package:path_provider/path_provider.dart';

class ICalExporter {
  /// Builds the iCal content string (without writing to file).
  static String buildICalContent(List<AbsenceWithMember> absences, {DateTime? now}) {
    final buffer =
        StringBuffer()
          ..writeln('BEGIN:VCALENDAR')
          ..writeln('VERSION:2.0')
          ..writeln('PRODID:-//Crewmeister Absence Manager//EN');

    final timestamp = _formatDateTime((now ?? DateTime.now()).toUtc());

    for (final entry in absences) {
      final absence = entry.absence;
      final member = entry.member;

      if (absence.startDate == null || absence.endDate == null) continue;

      buffer
        ..writeln('BEGIN:VEVENT')
        ..writeln('UID:${absence.id}-${member.userId}@crewmeister')
        ..writeln('DTSTAMP:$timestamp')
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
    return buffer.toString();
  }

  /// Writes the iCal file to disk (used in production).
  static Future<File> generateICalFile(List<AbsenceWithMember> absences) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/absences_${DateTime.now().millisecondsSinceEpoch}.ics');
    final content = buildICalContent(absences);
    await file.writeAsString(content);
    return file;
  }

  static String _formatDate(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}'
        '${date.month.toString().padLeft(2, '0')}'
        '${date.day.toString().padLeft(2, '0')}';
  }

  static String _formatDateTime(DateTime dateTime) {
    return '${_formatDate(dateTime)}T'
        '${dateTime.hour.toString().padLeft(2, '0')}'
        '${dateTime.minute.toString().padLeft(2, '0')}'
        '${dateTime.second.toString().padLeft(2, '0')}Z';
  }
}
