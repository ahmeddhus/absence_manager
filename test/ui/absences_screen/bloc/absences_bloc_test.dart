import 'package:absence_manager/core/result/result.dart';
import 'package:absence_manager/domain/models/absence/absence.dart';
import 'package:absence_manager/domain/models/absence/absence_type.dart';
import 'package:absence_manager/domain/models/absence_list_with_members.dart';
import 'package:absence_manager/domain/models/absence_with_member.dart';
import 'package:absence_manager/domain/models/member/member.dart';
import 'package:absence_manager/domain/use_cases/absence_i_cal_exporter.dart';
import 'package:absence_manager/domain/use_cases/get_absences_with_members_use_case.dart';
import 'package:absence_manager/ui/absence/bloc/absence_bloc.dart';
import 'package:absence_manager/ui/absence/bloc/absence_event.dart';
import 'package:absence_manager/ui/absence/bloc/absence_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'absences_bloc_test.mocks.dart';

class FakeGetAbsencesWithMembersUseCase implements GetAbsencesWithMembersUseCase {
  Future<Result<AbsenceListWithMembers>> Function({
    required int offset,
    required int limit,
    String? type,
    DateTimeRange? dateRange,
  })?
  stub;

  @override
  Future<Result<AbsenceListWithMembers>> call({
    required int offset,
    required int limit,
    String? type,
    DateTimeRange? dateRange,
  }) {
    assert(stub != null, 'You must set a stub before calling the use case.');
    return stub!(offset: offset, limit: limit, type: type, dateRange: dateRange);
  }
}

@GenerateMocks([AbsenceICalExporter])
void main() {
  late FakeGetAbsencesWithMembersUseCase useCase;
  late MockAbsenceICalExporter exporter;
  late AbsencesBloc bloc;

  final fakeAbsence = Absence(
    id: 1,
    userId: 1,
    type: AbsenceType.vacation,
    startDate: DateTime(2024, 1, 1),
    endDate: DateTime(2024, 1, 2),
    status: AbsenceStatus.confirmed,
  );

  final fakeMember = Member(userId: 1, name: 'John', imageUrl: '');

  final fakeData = AbsenceListWithMembers(
    totalCount: 1,
    absences: [AbsenceWithMember(absence: fakeAbsence, member: fakeMember)],
  );

  setUp(() {
    useCase = FakeGetAbsencesWithMembersUseCase();
    exporter = MockAbsenceICalExporter();
    bloc = AbsencesBloc(useCase, exporter);
  });

  blocTest<AbsencesBloc, AbsencesState>(
    'emits [initial loading=true, loaded] on LoadAbsences success',
    build: () {
      useCase.stub = ({
        required int offset,
        required int limit,
        String? type,
        DateTimeRange? dateRange,
      }) async {
        return Result.ok(fakeData);
      };
      return bloc;
    },
    act: (bloc) => bloc.add(LoadAbsences()),
    expect:
        () => [
          isA<AbsencesLoaded>().having((s) => s.isInitialLoading, 'isInitialLoading', true),
          isA<AbsencesLoaded>()
              .having((s) => s.absences.length, 'absences', 1)
              .having((s) => s.totalCount, 'totalCount', 1)
              .having((s) => s.isInitialLoading, 'isInitialLoading', false),
        ],
  );

  blocTest<AbsencesBloc, AbsencesState>(
    'emits [initial loading=true, error] on LoadAbsences failure',
    build: () {
      useCase.stub = ({
        required int offset,
        required int limit,
        String? type,
        DateTimeRange? dateRange,
      }) async {
        return Result.error(Exception('fail'));
      };
      return bloc;
    },
    act: (bloc) => bloc.add(LoadAbsences()),
    expect:
        () => [
          isA<AbsencesLoaded>().having((s) => s.isInitialLoading, 'isInitialLoading', true),
          isA<AbsencesError>().having((e) => e.message, 'message', contains('fail')),
        ],
  );

  blocTest<AbsencesBloc, AbsencesState>(
    'emits [paginating=true, updated loaded] on LoadMoreAbsences',
    build: () {
      useCase.stub = ({
        required int offset,
        required int limit,
        String? type,
        DateTimeRange? dateRange,
      }) async {
        return Result.ok(fakeData);
      };
      return bloc;
    },
    act: (bloc) async {
      bloc.add(LoadAbsences());
      await Future.delayed(Duration.zero);
      bloc.add(LoadMoreAbsences(offset: 10, limit: 10));
    },
    skip: 2,
    expect:
        () => [
          isA<AbsencesLoaded>().having((s) => s.isLoadingMore, 'isPaginating', true),
          isA<AbsencesLoaded>()
              .having((s) => s.absences.length, 'absences after merge', 2)
              .having((s) => s.isLoadingMore, 'isPaginating', false),
        ],
  );

  blocTest<AbsencesBloc, AbsencesState>(
    'emits exporting state on ExportAbsencesToICal',
    build: () {
      useCase.stub = ({
        required int offset,
        required int limit,
        String? type,
        DateTimeRange? dateRange,
      }) async {
        return Result.ok(fakeData);
      };
      when(exporter.export(any)).thenAnswer((_) async {});
      return bloc;
    },
    act: (bloc) async {
      bloc.add(LoadAbsences());
      await Future.delayed(Duration.zero);
      bloc.add(ExportAbsencesToICal());
    },
    skip: 2,
    expect:
        () => [
          isA<AbsencesLoaded>().having((s) => s.isExporting, 'isExporting', true),
          isA<AbsencesLoaded>().having((s) => s.isExporting, 'isExporting', false),
        ],
  );
}
