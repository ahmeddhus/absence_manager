import 'package:absence_manager/domain/models/absence/absence.dart';
import 'package:absence_manager/domain/models/absence_list_with_members.dart';
import 'package:absence_manager/domain/models/absence_with_member.dart';
import 'package:absence_manager/domain/models/member/member.dart';
import 'package:absence_manager/domain/use_cases/get_absences_with_members_use_case.dart';
import 'package:absence_manager/ui/absence/bloc/absence_bloc.dart';
import 'package:absence_manager/ui/absence/bloc/absence_event.dart';
import 'package:absence_manager/ui/absence/bloc/absence_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([GetAbsencesWithMembersUseCase])
import 'absences_bloc_test.mocks.dart';

void main() {
  late MockGetAbsencesWithMembersUseCase mockUseCase;
  late AbsencesBloc absencesBloc;

  setUp(() {
    mockUseCase = MockGetAbsencesWithMembersUseCase();
    absencesBloc = AbsencesBloc(mockUseCase);
  });

  tearDown(() {
    absencesBloc.close();
  });

  final absence = Absence(
    id: 1,
    userId: 100,
    type: 'vacation',
    startDate: DateTime(2024, 1, 1),
    endDate: DateTime(2024, 1, 10),
    memberNote: 'Vacation',
    admitterNote: 'Approved',
    status: AbsenceStatus.confirmed,
  );

  final member = Member(userId: 100, name: 'Alice', imageUrl: '');

  final absenceListWithMembers = AbsenceListWithMembers(
    totalCount: 1,
    absences: [AbsenceWithMember(absence: absence, member: member)],
  );

  blocTest<AbsencesBloc, AbsencesState>(
    'emits [AbsencesLoading, AbsencesLoaded] when LoadAbsences event is added',
    build: () {
      when(
        mockUseCase.execute(offset: 0, limit: 10),
      ).thenAnswer((_) async => absenceListWithMembers);
      return absencesBloc;
    },
    act: (bloc) => bloc.add(LoadAbsences()),
    expect:
        () => [
          AbsencesLoading(),
          AbsencesLoaded(
            absences: absenceListWithMembers.absences,
            hasMore: absenceListWithMembers.absences.length == 10,
            totalCount: absenceListWithMembers.totalCount,
          ),
        ],
    verify: (_) {
      verify(mockUseCase.execute(offset: 0, limit: 10)).called(1);
    },
  );

  blocTest<AbsencesBloc, AbsencesState>(
    'emits [AbsencesLoading, AbsencesError] when LoadAbsences event fails',
    build: () {
      when(
        mockUseCase.execute(offset: 0, limit: 10),
      ).thenThrow(Exception('Failed to fetch absences'));
      return absencesBloc;
    },
    act: (bloc) => bloc.add(LoadAbsences()),
    expect: () => [AbsencesLoading(), isA<AbsencesError>()],
    verify: (_) {
      verify(mockUseCase.execute(offset: 0, limit: 10)).called(1);
    },
  );

  blocTest<AbsencesBloc, AbsencesState>(
    'emits [AbsencesLoadingMore, AbsencesLoaded] when LoadMoreAbsences event is added',
    build: () {
      final currentState = AbsencesLoaded(
        absences: absenceListWithMembers.absences,
        hasMore: true,
        totalCount: absenceListWithMembers.totalCount,
      );

      absencesBloc.emit(currentState);

      when(
        mockUseCase.execute(offset: 10, limit: 10),
      ).thenAnswer((_) async => absenceListWithMembers);
      return absencesBloc;
    },
    act: (bloc) => bloc.add(LoadMoreAbsences(offset: 10, limit: 10)),
    expect:
        () => [
          AbsencesLoadingMore(),
          AbsencesLoaded(
            absences: absenceListWithMembers.absences + absenceListWithMembers.absences,
            hasMore: absenceListWithMembers.absences.length == 10,
            totalCount: absenceListWithMembers.totalCount,
          ),
        ],
    verify: (_) {
      verify(mockUseCase.execute(offset: 10, limit: 10)).called(1);
    },
  );

  blocTest<AbsencesBloc, AbsencesState>(
    'emits [AbsencesLoadingMore, AbsencesError] when LoadMoreAbsences fails',
    build: () {
      final currentState = AbsencesLoaded(
        absences: absenceListWithMembers.absences,
        hasMore: true,
        totalCount: absenceListWithMembers.totalCount,
      );

      absencesBloc.emit(currentState);

      when(
        mockUseCase.execute(offset: 10, limit: 10),
      ).thenThrow(Exception('Failed to fetch more absences'));
      return absencesBloc;
    },
    act: (bloc) => bloc.add(LoadMoreAbsences(offset: 10, limit: 10)),
    expect: () => [AbsencesLoadingMore(), isA<AbsencesError>()],
    verify: (_) {
      verify(mockUseCase.execute(offset: 10, limit: 10)).called(1);
    },
  );
}
