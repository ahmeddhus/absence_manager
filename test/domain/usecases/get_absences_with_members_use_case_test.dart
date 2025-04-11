import 'package:absence_manager/data/repositories/absence/absence_repository.dart';
import 'package:absence_manager/data/repositories/member/member_repository.dart';
import 'package:absence_manager/domain/models/absence/absence.dart';
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
    test('returns first page of AbsenceWithMember list when userIds match', () async {
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
        mockAbsenceRepo.getAllAbsences(offset: 0, limit: 1),
      ).thenAnswer((_) async => [absences[0]]);
      when(mockMemberRepo.getAllMembers()).thenAnswer((_) async => members);

      final result = await useCase.execute(offset: 0, limit: 1);

      expect(result, isA<List<AbsenceWithMember>>());
      expect(result.length, 1);
      expect(result.first.absence.id, 1);
      expect(result.first.member.name, "Alice");
    });

    test('returns second page of AbsenceWithMember list when userIds match', () async {
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
        mockAbsenceRepo.getAllAbsences(offset: 1, limit: 1),
      ).thenAnswer((_) async => [absences[1]]);
      when(mockMemberRepo.getAllMembers()).thenAnswer((_) async => members);

      final result = await useCase.execute(offset: 1, limit: 1);

      expect(result, isA<List<AbsenceWithMember>>());
      expect(result.length, 1);
      expect(result.first.absence.id, 2);
      expect(result.first.member.name, "Alice");
    });

    test('returns empty list when offset exceeds total absences', () async {
      final members = [
        Member(userId: 101, name: "Alice", imageUrl: "http://example.com/image.png"),
      ];

      when(mockAbsenceRepo.getAllAbsences(offset: 20, limit: 1)).thenAnswer((_) async => []);
      when(mockMemberRepo.getAllMembers()).thenAnswer((_) async => members);

      final result = await useCase.execute(offset: 20, limit: 1);

      expect(result, isEmpty);
    });

    test('uses fallback "Unknown" member for all absences if member list is empty', () async {
      final absences = [
        Absence(
          id: 3,
          userId: 101,
          type: "vacation",
          startDate: DateTime(2021, 3, 1),
          endDate: DateTime(2021, 3, 5),
          memberNote: null,
          admitterNote: null,
          status: AbsenceStatus.requested,
        ),
      ];

      when(mockAbsenceRepo.getAllAbsences(offset: 0, limit: 1)).thenAnswer((_) async => absences);
      when(mockMemberRepo.getAllMembers()).thenAnswer((_) async => []);

      final result = await useCase.execute(offset: 0, limit: 1);

      expect(result.length, 1);
      expect(result.first.member.name, "Unknown");
      expect(result.first.member.userId, 101); // fallback still keeps the userId
    });
  });
}
