import 'package:absence_manager/domain/models/absence/absence.dart';
import 'package:absence_manager/domain/models/absence/absence_type.dart';
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
    type: AbsenceType.vacation,
    startDate: DateTime(2024, 1, 1),
    endDate: DateTime(2024, 1, 10),
    memberNote: 'Vacation',
    admitterNote: 'Approved',
    status: AbsenceStatus.confirmed,
  );

  final member = Member(userId: 100, name: 'Alice', imageUrl: '');

  final absenceWithMember = AbsenceWithMember(absence: absence, member: member);

  final absenceListWithMembers = AbsenceListWithMembers(
    totalCount: 1,
    absences: [absenceWithMember],
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
            hasMore: false,
            totalCount: absenceListWithMembers.totalCount,
          ),
        ],
  );

  blocTest<AbsencesBloc, AbsencesState>(
    'emits [AbsencesLoading, AbsencesError] when LoadAbsences throws',
    build: () {
      when(mockUseCase.execute(offset: 0, limit: 10)).thenThrow(Exception('Oops'));
      return absencesBloc;
    },
    act: (bloc) => bloc.add(LoadAbsences()),
    expect: () => [AbsencesLoading(), isA<AbsencesError>()],
  );

  blocTest<AbsencesBloc, AbsencesState>(
    'emits [AbsencesLoadingMore, AbsencesLoaded] on successful LoadMoreAbsences',
    build: () {
      when(
        mockUseCase.execute(offset: 10, limit: 10),
      ).thenAnswer((_) async => absenceListWithMembers);

      return absencesBloc;
    },
    seed: () => AbsencesLoaded(absences: [absenceWithMember], hasMore: true, totalCount: 1),
    act: (bloc) => bloc.add(LoadMoreAbsences(offset: 10, limit: 10)),
    expect:
        () => [
          AbsencesLoadingMore(),
          AbsencesLoaded(
            absences: [absenceWithMember, absenceWithMember],
            hasMore: false,
            totalCount: 1,
          ),
        ],
  );

  blocTest<AbsencesBloc, AbsencesState>(
    'emits [AbsencesLoadingMore, AbsencesError] on LoadMoreAbsences failure',
    build: () {
      when(mockUseCase.execute(offset: 10, limit: 10)).thenThrow(Exception('Failed'));
      return absencesBloc;
    },
    seed: () => AbsencesLoaded(absences: [absenceWithMember], hasMore: true, totalCount: 1),
    act: (bloc) => bloc.add(LoadMoreAbsences(offset: 10, limit: 10)),
    expect: () => [AbsencesLoadingMore(), isA<AbsencesError>()],
  );

  blocTest<AbsencesBloc, AbsencesState>(
    'emits [AbsencesLoading, AbsencesLoaded] when FilterAbsences is applied and matches',
    build: () {
      when(
        mockUseCase.execute(offset: 0, limit: 100),
      ).thenAnswer((_) async => absenceListWithMembers);
      return absencesBloc;
    },
    act: (bloc) => bloc.add(FilterAbsences(type: AbsenceType.vacation)),
    expect:
        () => [
          AbsencesLoading(),
          AbsencesLoaded(
            absences: absenceListWithMembers.absences,
            hasMore: false,
            totalCount: 1,
            selectedType: AbsenceType.vacation,
            selectedDateRange: null,
          ),
        ],
  );

  blocTest<AbsencesBloc, AbsencesState>(
    'emits [AbsencesLoading, AbsencesLoaded] with empty list if no absences match filter',
    build: () {
      final emptyResult = AbsenceListWithMembers(totalCount: 1, absences: []);
      when(mockUseCase.execute(offset: 0, limit: 100)).thenAnswer((_) async => emptyResult);
      return absencesBloc;
    },
    act: (bloc) => bloc.add(FilterAbsences(type: AbsenceType.sickness)),
    expect:
        () => [
          AbsencesLoading(),
          AbsencesLoaded(
            absences: [],
            hasMore: false,
            totalCount: 1,
            selectedType: AbsenceType.sickness,
            selectedDateRange: null,
          ),
        ],
  );
}
