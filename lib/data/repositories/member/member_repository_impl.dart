import 'package:absence_manager/data/repositories/member/member_repository.dart';
import 'package:absence_manager/data/services/api/mappers/member_api_mapper.dart';
import 'package:absence_manager/data/services/api/member_remote_service.dart';
import 'package:absence_manager/data/services/local/mappers/member_cache_mapper.dart';
import 'package:absence_manager/data/services/local/member_local_service.dart';
import 'package:absence_manager/domain/models/member/member.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class MemberRepositoryImpl implements MemberRepository {
  final MemberRemoteService _remoteService;
  final MemberLocalService _localService;

  MemberRepositoryImpl({
    required MemberRemoteService remoteService,
    required MemberLocalService localService,
  }) : _remoteService = remoteService,
       _localService = localService;

  @override
  Future<List<Member>> getAllMembers() async {
    final isOnline = await _hasConnection();

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

  Future<bool> _hasConnection() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
