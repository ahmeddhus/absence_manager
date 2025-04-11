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

  test('returns combined AbsenceWithMember list when userIds match', () async {
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
    ];

    final members = [Member(userId: 101, name: "Alice", imageUrl: "http://example.com/image.png")];

    when(mockAbsenceRepo.getAllAbsences()).thenAnswer((_) async => absences);
    when(mockMemberRepo.getAllMembers()).thenAnswer((_) async => members);

    final result = await useCase.execute();

    expect(result, isA<List<AbsenceWithMember>>());
    expect(result.length, 1);
    expect(result.first.absence.id, 1);
    expect(result.first.member.name, "Alice");
  });

  test('uses fallback "Unknown" member when member is missing', () async {
    final absences = [
      Absence(
        id: 2,
        userId: 999, // userId not in member list
        type: "sickness",
        startDate: DateTime(2021, 2, 1),
        endDate: DateTime(2021, 2, 3),
        memberNote: null,
        admitterNote: null,
        status: AbsenceStatus.requested,
      ),
    ];

    final members = [Member(userId: 101, name: "Alice", imageUrl: "http://example.com/image.png")];

    when(mockAbsenceRepo.getAllAbsences()).thenAnswer((_) async => absences);
    when(mockMemberRepo.getAllMembers()).thenAnswer((_) async => members);

    final result = await useCase.execute();

    expect(result.length, 1);
    expect(result.first.absence.userId, 999);
    expect(result.first.member.name, "Unknown");
  });

  test('returns empty list when no absences exist', () async {
    final members = [Member(userId: 101, name: "Alice", imageUrl: "http://example.com/image.png")];

    when(mockAbsenceRepo.getAllAbsences()).thenAnswer((_) async => []);
    when(mockMemberRepo.getAllMembers()).thenAnswer((_) async => members);

    final result = await useCase.execute();

    expect(result, isEmpty);
  });

  test('uses fallback "Unknown" for all absences if member list is empty', () async {
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

    when(mockAbsenceRepo.getAllAbsences()).thenAnswer((_) async => absences);
    when(mockMemberRepo.getAllMembers()).thenAnswer((_) async => []);

    final result = await useCase.execute();

    expect(result.length, 1);
    expect(result.first.member.name, "Unknown");
    expect(result.first.member.userId, 101); // fallback still keeps the userId
  });
}
