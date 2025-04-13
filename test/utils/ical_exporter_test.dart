import 'package:absence_manager/domain/models/absence/absence.dart';
import 'package:absence_manager/domain/models/absence/absence_type.dart';
import 'package:absence_manager/domain/models/absence_with_member.dart';
import 'package:absence_manager/domain/models/member/member.dart';
import 'package:absence_manager/utils/i_cal_exporter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ICalExporter.buildICalContent', () {
    test('generates correct iCal string for one valid absence', () {
      // Arrange
      final fixedNow = DateTime.utc(2024, 4, 1, 10, 30, 0);
      final absences = [
        AbsenceWithMember(
          absence: Absence(
            id: 1,
            userId: 10,
            type: AbsenceType.vacation,
            status: AbsenceStatus.confirmed,
            startDate: DateTime(2024, 4, 10),
            endDate: DateTime(2024, 4, 12),
            memberNote: 'Family trip',
            admitterNote: null,
          ),
          member: Member(userId: 10, name: 'John Doe', imageUrl: ''),
        ),
      ];

      // Act
      final result = ICalExporter.buildICalContent(absences, now: fixedNow);

      // Assert
      expect(result, contains('BEGIN:VCALENDAR'));
      expect(result, contains('END:VCALENDAR'));
      expect(result, contains('BEGIN:VEVENT'));
      expect(result, contains('END:VEVENT'));
      expect(result, contains('UID:1-10@crewmeister'));
      expect(result, contains('DTSTAMP:20240401T103000Z'));
      expect(result, contains('DTSTART;VALUE=DATE:20240410'));
      expect(result, contains('DTEND;VALUE=DATE:20240413'));
      expect(result, contains('SUMMARY:John Doe - Vacation'));
      expect(result, contains('STATUS:CONFIRMED'));
      expect(result, contains('DESCRIPTION:Family trip'));
    });

    test('skips absences with null start or end dates', () {
      final absences = [
        AbsenceWithMember(
          absence: Absence(
            id: 2,
            userId: 11,
            type: AbsenceType.sickness,
            status: AbsenceStatus.requested,
            startDate: null,
            endDate: DateTime(2024, 4, 10),
          ),
          member: Member(userId: 11, name: 'Jane Doe', imageUrl: ''),
        ),
        AbsenceWithMember(
          absence: Absence(
            id: 3,
            userId: 12,
            type: AbsenceType.vacation,
            status: AbsenceStatus.rejected,
            startDate: DateTime(2024, 4, 10),
            endDate: null,
          ),
          member: Member(userId: 12, name: 'Alex Turner', imageUrl: ''),
        ),
      ];

      final result = ICalExporter.buildICalContent(absences);
      expect(result.contains('BEGIN:VEVENT'), isFalse);
      expect(result.contains('SUMMARY:'), isFalse);
    });

    test('generates empty calendar for empty absence list', () {
      final result = ICalExporter.buildICalContent([]);
      expect(result.contains('BEGIN:VEVENT'), isFalse);
      expect(result.contains('END:VEVENT'), isFalse);
      expect(result.contains('BEGIN:VCALENDAR'), isTrue);
      expect(result.contains('END:VCALENDAR'), isTrue);
    });
  });
}
