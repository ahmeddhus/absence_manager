import 'package:absence_manager/core/network/network_checker.dart';
import 'package:absence_manager/data/repositories/absence/absence_repository_impl.dart';
import 'package:absence_manager/data/services/api/absence_remote_service.dart';
import 'package:absence_manager/data/services/api/model/absence/absence_api_model.dart';
import 'package:absence_manager/data/services/local/absence_local_service.dart';
import 'package:absence_manager/data/services/local/model/absence/absence_cache_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'absence_repository_impl_test.mocks.dart';

@GenerateMocks([AbsenceRemoteService, AbsenceLocalService, NetworkChecker])
void main() {
  late MockAbsenceRemoteService remoteService;
  late MockAbsenceLocalService localService;
  late MockNetworkChecker networkChecker;
  late AbsenceRepositoryImpl repository;

  setUp(() {
    remoteService = MockAbsenceRemoteService();
    localService = MockAbsenceLocalService();
    networkChecker = MockNetworkChecker();
    repository = AbsenceRepositoryImpl(
      remoteService: remoteService,
      localService: localService,
      network: networkChecker,
    );
  });

  test('should fetch from remote and cache when online', () async {
    when(networkChecker.hasConnection).thenAnswer((_) async => true);
    final apiModels = [
      AbsenceApiModel(
        id: 1,
        userId: 1,
        type: 'vacation',
        startDate: '2024-01-01',
        endDate: '2024-01-02',
      ),
    ];

    when(
      remoteService.fetchAbsences(page: 1, limit: 10, type: null, from: null, to: null),
    ).thenAnswer((_) async => (1, apiModels));

    when(localService.saveAbsences(any)).thenAnswer((_) async => {});

    final result = await repository.getAllAbsences(offset: 0, limit: 10);

    expect(result.totalCount, 1);
    expect(result.absences.first.id, 1);
    verify(localService.saveAbsences(any)).called(1);
  });

  test('should return cached data when offline', () async {
    when(networkChecker.hasConnection).thenAnswer((_) async => false);
    final cachedModels = [
      AbsenceCacheModel()
        ..id = 2
        ..userId = 2
        ..type = 'sickness'
        ..startDate = '2024-01-05'
        ..endDate = '2024-01-06',
    ];

    when(localService.getCachedAbsences()).thenAnswer((_) async => cachedModels);

    final result = await repository.getAllAbsences(offset: 0, limit: 10);

    expect(result.totalCount, 1);
    expect(result.absences.first.id, 2);
  });

  test('should fallback to cache if remote throws error', () async {
    when(networkChecker.hasConnection).thenAnswer((_) async => true);
    when(
      remoteService.fetchAbsences(page: 1, limit: 10, type: null, from: null, to: null),
    ).thenThrow(Exception('Server error'));

    final cachedModels = [
      AbsenceCacheModel()
        ..id = 3
        ..userId = 3
        ..type = 'vacation'
        ..startDate = '2024-01-10'
        ..endDate = '2024-01-11',
    ];

    when(localService.getCachedAbsences()).thenAnswer((_) async => cachedModels);

    final result = await repository.getAllAbsences(offset: 0, limit: 10);

    expect(result.totalCount, 1);
    expect(result.absences.first.id, 3);
    verify(localService.getCachedAbsences()).called(1);
  });
}
