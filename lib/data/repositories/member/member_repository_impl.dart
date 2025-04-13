import 'package:absence_manager/core/network/network_checker.dart';
import 'package:absence_manager/data/repositories/member/member_repository.dart';
import 'package:absence_manager/data/services/api/mappers/member_api_mapper.dart';
import 'package:absence_manager/data/services/api/member_remote_service.dart';
import 'package:absence_manager/data/services/local/mappers/member_cache_mapper.dart';
import 'package:absence_manager/data/services/local/member_local_service.dart';
import 'package:absence_manager/domain/models/member/member.dart';

class MemberRepositoryImpl implements MemberRepository {
  final MemberRemoteService _remoteService;
  final MemberLocalService _localService;
  final NetworkChecker _network;

  MemberRepositoryImpl({
    required MemberRemoteService remoteService,
    required MemberLocalService localService,
    required NetworkChecker network,
  }) : _remoteService = remoteService,
       _localService = localService,
       _network = network;

  @override
  Future<List<Member>> getAllMembers() async {
    final isOnline = await _network.hasConnection;

    try {
      if (isOnline) {
        final remoteMembers = await _remoteService.fetchMembers();
        await _localService.saveMembers(remoteMembers.map((e) => e.toCacheModel()).toList());
        return remoteMembers.map((e) => e.toDomain()).toList();
      } else {
        final cached = await _localService.getCachedMembers();
        return cached.map((e) => e.toApiModel().toDomain()).toList();
      }
    } catch (_) {
      final fallback = await _localService.getCachedMembers();
      return fallback.map((e) => e.toApiModel().toDomain()).toList();
    }
  }
}
