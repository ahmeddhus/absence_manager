import 'package:absence_manager/domain/models/absence/absence.dart';
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

  setUp(() {
    mockUseCase = MockGetAbsencesWithMembersUseCase();
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

  final combined = [AbsenceWithMember(absence: absence, member: member)];

  blocTest<AbsencesBloc, AbsencesState>(
    'emits [Loading, Loaded] when use case succeeds',
    build: () {
      when(mockUseCase.execute()).thenAnswer((_) async => combined);
      return AbsencesBloc(mockUseCase);
    },
    act: (bloc) => bloc.add(LoadAbsences()),
    expect: () => [AbsencesLoading(), AbsencesLoaded(combined)],
  );

  blocTest<AbsencesBloc, AbsencesState>(
    'emits [Loading, Loaded (empty)] when use case returns empty list',
    build: () {
      when(mockUseCase.execute()).thenAnswer((_) async => []);
      return AbsencesBloc(mockUseCase);
    },
    act: (bloc) => bloc.add(LoadAbsences()),
    expect: () => [AbsencesLoading(), AbsencesLoaded([])],
  );

  blocTest<AbsencesBloc, AbsencesState>(
    'emits [Loading, Error] when use case throws',
    build: () {
      when(mockUseCase.execute()).thenThrow(Exception("Oops"));
      return AbsencesBloc(mockUseCase);
    },
    act: (bloc) => bloc.add(LoadAbsences()),
    expect: () => [AbsencesLoading(), isA<AbsencesError>()],
    verify: (_) {
      verify(mockUseCase.execute()).called(1);
    },
  );

  blocTest<AbsencesBloc, AbsencesState>(
    'handles multiple LoadAbsences events sequentially',
    build: () {
      when(mockUseCase.execute()).thenAnswer((_) async => combined);
      return AbsencesBloc(mockUseCase);
    },
    act: (bloc) async {
      bloc.add(LoadAbsences());
      await Future.delayed(const Duration(milliseconds: 10));
      bloc.add(LoadAbsences());
    },
    wait: const Duration(milliseconds: 50),
    expect:
        () => [
          AbsencesLoading(),
          AbsencesLoaded(combined),
          AbsencesLoading(),
          AbsencesLoaded(combined),
        ],
    verify: (_) {
      verify(mockUseCase.execute()).called(2);
    },
  );
}
