import 'package:absence_manager/data/repositories/absence/absence_repository.dart';
import 'package:absence_manager/data/services/api/absence_remote_service.dart';
import 'package:absence_manager/data/services/api/mappers/absence_api_mapper.dart';
import 'package:absence_manager/data/services/local/absence_local_service.dart';
import 'package:absence_manager/data/services/local/mappers/absence_cache_mapper.dart';
import 'package:absence_manager/domain/models/absence/absence_list.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AbsenceRepositoryImpl implements AbsenceRepository {
  final AbsenceRemoteService _remoteService;
  final AbsenceLocalService _localService;

  AbsenceRepositoryImpl({
    required AbsenceRemoteService remoteService,
    required AbsenceLocalService localService,
  }) : _remoteService = remoteService,
       _localService = localService;

  @override
  Future<AbsenceList> getAllAbsences({required int offset, required int limit}) async {
    final isOnline = await _hasConnection();

    try {
      if (isOnline) {
        final remoteAbsences = await _remoteService.fetchAbsences();
        await _localService.saveAbsences(remoteAbsences.map((e) => e.toCacheModel()).toList());
        return AbsenceList(
          totalCount: remoteAbsences.length,
          absences: remoteAbsences.map((e) => e.toDomain()).toList(),
        );
      } else {
        final cached = await _localService.getCachedAbsences();
        return AbsenceList(
          totalCount: cached.length,
          absences: cached.map((e) => e.toApiModel().toDomain()).toList(),
        );
      }
    } catch (_) {
      final fallback = await _localService.getCachedAbsences();
      return AbsenceList(
        totalCount: fallback.length,
        absences: fallback.map((e) => e.toApiModel().toDomain()).toList(),
      );
    }
  }

  Future<bool> _hasConnection() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
