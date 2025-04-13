import 'package:absence_manager/core/network/network_checker.dart';
import 'package:absence_manager/data/repositories/member/member_repository_impl.dart';
import 'package:absence_manager/data/services/api/member_remote_service.dart';
import 'package:absence_manager/data/services/api/model/member/member_api_model.dart';
import 'package:absence_manager/data/services/local/member_local_service.dart';
import 'package:absence_manager/data/services/local/model/member/member_cache_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'member_repository_impl_test.mocks.dart';

@GenerateMocks([MemberRemoteService, MemberLocalService, NetworkChecker])
void main() {
  late MockMemberRemoteService remoteService;
  late MockMemberLocalService localService;
  late MockNetworkChecker networkChecker;
  late MemberRepositoryImpl repository;

  setUp(() {
    remoteService = MockMemberRemoteService();
    localService = MockMemberLocalService();
    networkChecker = MockNetworkChecker();
    repository = MemberRepositoryImpl(
      remoteService: remoteService,
      localService: localService,
      network: networkChecker,
    );
  });

  test('should fetch from remote and cache when online', () async {
    when(networkChecker.hasConnection).thenAnswer((_) async => true);

    final apiModels = [MemberApiModel(userId: 1, name: 'John', image: '')];

    when(remoteService.fetchMembers()).thenAnswer((_) async => apiModels);
    when(localService.saveMembers(any)).thenAnswer((_) async => {});

    final result = await repository.getAllMembers();

    expect(result.length, 1);
    expect(result.first.userId, 1);
    expect(result.first.name, 'John');
    verify(localService.saveMembers(any)).called(1);
  });

  test('should return cached data when offline', () async {
    when(networkChecker.hasConnection).thenAnswer((_) async => false);

    final cachedModels = [MemberCacheModel(userId: 2, name: 'Jane', imageUrl: '')];

    when(localService.getCachedMembers()).thenAnswer((_) async => cachedModels);

    final result = await repository.getAllMembers();

    expect(result.length, 1);
    expect(result.first.userId, 2);
    expect(result.first.name, 'Jane');
    verify(localService.getCachedMembers()).called(1);
  });

  test('should fallback to cache if remote throws error', () async {
    when(networkChecker.hasConnection).thenAnswer((_) async => true);
    when(remoteService.fetchMembers()).thenThrow(Exception('fail'));

    final cachedModels = [MemberCacheModel(userId: 3, name: 'Sam', imageUrl: '')];

    when(localService.getCachedMembers()).thenAnswer((_) async => cachedModels);

    final result = await repository.getAllMembers();

    expect(result.length, 1);
    expect(result.first.userId, 3);
    expect(result.first.name, 'Sam');
    verify(localService.getCachedMembers()).called(1);
  });
}
