import 'package:absence_manager/core/result/result.dart';
import 'package:absence_manager/data/repositories/absence/absence_repository.dart';
import 'package:absence_manager/data/repositories/member/member_repository.dart';
import 'package:absence_manager/domain/models/absence/absence.dart';
import 'package:absence_manager/domain/models/absence/absence_list.dart';
import 'package:absence_manager/domain/models/absence/absence_type.dart';
import 'package:absence_manager/domain/models/absence_list_with_members.dart';
import 'package:absence_manager/domain/models/member/member.dart';
import 'package:absence_manager/domain/use_cases/get_absences_with_members_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_absences_with_members_use_case_test.mocks.dart';

@GenerateMocks([AbsenceRepository, MemberRepository])
void main() {
  late MockAbsenceRepository absenceRepository;
  late MockMemberRepository memberRepository;
  late GetAbsencesWithMembersUseCase useCase;

  setUp(() {
    absenceRepository = MockAbsenceRepository();
    memberRepository = MockMemberRepository();
    useCase = GetAbsencesWithMembersUseCase(
      absenceRepository: absenceRepository,
      memberRepository: memberRepository,
    );
  });

  final absence = Absence(
    id: 1,
    userId: 10,
    type: AbsenceType.vacation,
    startDate: DateTime(2024, 01, 01),
    endDate: DateTime(2024, 01, 02),
    memberNote: null,
    admitterNote: null,
    status: AbsenceStatus.confirmed,
  );

  final member = Member(userId: 10, name: 'John Doe', imageUrl: '');

  test('should return combined AbsenceWithMember list when repositories succeed', () async {
    when(
      absenceRepository.getAllAbsences(
        offset: anyNamed('offset'),
        limit: anyNamed('limit'),
        type: anyNamed('type'),
        from: anyNamed('from'),
        to: anyNamed('to'),
      ),
    ).thenAnswer((_) async => AbsenceList(totalCount: 1, absences: [absence]));

    when(memberRepository.getAllMembers()).thenAnswer((_) async => [member]);

    final result = await useCase(offset: 0, limit: 10);

    expect(result, isA<Ok<AbsenceListWithMembers>>());
    final ok = result as Ok<AbsenceListWithMembers>;

    expect(ok.value.totalCount, 1);
    expect(ok.value.absences.first.absence.id, 1);
    expect(ok.value.absences.first.member.name, 'John Doe');
  });

  test('should return Result.error when absence repository throws', () async {
    when(
      absenceRepository.getAllAbsences(
        offset: anyNamed('offset'),
        limit: anyNamed('limit'),
        type: anyNamed('type'),
        from: anyNamed('from'),
        to: anyNamed('to'),
      ),
    ).thenThrow(Exception('failure'));

    final result = await useCase(offset: 0, limit: 10);

    expect(result, isA<Error>());
    final err = result as Error;
    expect(err.error.toString(), contains('failure'));
  });
}
