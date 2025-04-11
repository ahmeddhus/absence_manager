import 'package:absence_manager/data/repositories/absence/absence_repository.dart';
import 'package:absence_manager/data/repositories/member/member_repository.dart';
import 'package:absence_manager/domain/models/absence/absence.dart';
import 'package:absence_manager/domain/models/absence/absence_list.dart';
import 'package:absence_manager/domain/models/absence_with_member.dart';
import 'package:absence_manager/domain/models/member/member.dart';
import 'package:absence_manager/domain/use_cases/get_absences_with_members_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([AbsenceRepository, MemberRepository])
import 'get_absences_with_members_use_case_test.mocks.dart';

void main() {
  late MockAbsenceRepository mockAbsenceRepo;
  late MockMemberRepository mockMemberRepo;
  late GetAbsencesWithMembersUseCase useCase;

  setUp(() {
    mockAbsenceRepo = MockAbsenceRepository();
    mockMemberRepo = MockMemberRepository();
    useCase = GetAbsencesWithMembersUseCase(mockAbsenceRepo, mockMemberRepo);
  });

  group('GetAbsencesWithMembersUseCase', () {
    test('returns AbsenceListWithMembers with correct total count and members', () async {
      final absences = [
        Absence(
          id: 1,
          userId: 101,
          type: "vacation",
          startDate: DateTime(2021, 1, 1),
          endDate: DateTime(2021, 1, 5),
          memberNote: "Ski trip",
          admitterNote: "Approved",
          status: AbsenceStatus.confirmed,
        ),
        Absence(
          id: 2,
          userId: 101,
          type: "vacation",
          startDate: DateTime(2021, 1, 6),
          endDate: DateTime(2021, 1, 10),
          memberNote: "Ski trip",
          admitterNote: "Approved",
          status: AbsenceStatus.confirmed,
        ),
      ];

      final members = [
        Member(userId: 101, name: "Alice", imageUrl: "http://example.com/image.png"),
      ];

      when(
        mockAbsenceRepo.getAllAbsences(offset: 0, limit: 10),
      ).thenAnswer((_) async => AbsenceList(totalCount: 2, absences: absences));
      when(mockMemberRepo.getAllMembers()).thenAnswer((_) async => members);

      final result = await useCase.execute(offset: 0, limit: 10);

      expect(result.totalCount, 2);
      expect(result.absences, isA<List<AbsenceWithMember>>());
      expect(result.absences.length, 2);
      expect(result.absences.first.absence.id, 1);
      expect(result.absences.first.member.name, "Alice");
    });

    test('uses fallback "Unknown" member if no matching userId is found', () async {
      final absences = [
        Absence(
          id: 1,
          userId: 999,
          type: "vacation",
          startDate: DateTime(2021, 1, 1),
          endDate: DateTime(2021, 1, 5),
          memberNote: "Unknown trip",
          admitterNote: "Unknown",
          status: AbsenceStatus.requested,
        ),
      ];

      when(
        mockAbsenceRepo.getAllAbsences(offset: 0, limit: 10),
      ).thenAnswer((_) async => AbsenceList(totalCount: 1, absences: absences));
      when(mockMemberRepo.getAllMembers()).thenAnswer((_) async => []);

      final result = await useCase.execute(offset: 0, limit: 10);

      expect(result.totalCount, 1);
      expect(result.absences, isA<List<AbsenceWithMember>>());
      expect(result.absences.length, 1);
      expect(result.absences.first.member.name, "Unknown");
    });

    test('returns empty AbsenceListWithMembers if no absences exist', () async {
      when(
        mockAbsenceRepo.getAllAbsences(offset: 0, limit: 10),
      ).thenAnswer((_) async => AbsenceList(totalCount: 0, absences: []));
      when(mockMemberRepo.getAllMembers()).thenAnswer((_) async => []);

      final result = await useCase.execute(offset: 0, limit: 10);

      expect(result.totalCount, 0);
      expect(result.absences, isEmpty);
    });
  });
}
