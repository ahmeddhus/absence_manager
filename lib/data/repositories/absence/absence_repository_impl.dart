import 'package:absence_manager/core/network/network_checker.dart';
import 'package:absence_manager/data/repositories/absence/absence_repository.dart';
import 'package:absence_manager/data/services/api/absence_remote_service.dart';
import 'package:absence_manager/data/services/api/mappers/absence_api_mapper.dart';
import 'package:absence_manager/data/services/local/absence_local_service.dart';
import 'package:absence_manager/data/services/local/mappers/absence_cache_mapper.dart';
import 'package:absence_manager/domain/models/absence/absence_list.dart';

/// Repository implementation that manages loading absences from a remote API
/// with local Hive caching as a fallback for offline scenarios.
class AbsenceRepositoryImpl implements AbsenceRepository {
  final AbsenceRemoteService _remoteService;
  final AbsenceLocalService _localService;
  final NetworkChecker _network;

  AbsenceRepositoryImpl({
    required AbsenceRemoteService remoteService,
    required AbsenceLocalService localService,
    required NetworkChecker network,
  }) : _remoteService = remoteService,
       _localService = localService,
       _network = network;

  @override
  Future<AbsenceList> getAllAbsences({
    required int offset,
    required int limit,
    String? type,
    DateTime? from,
    DateTime? to,
  }) async {
    final isOnline = await _network.hasConnection;
    final page = (offset ~/ limit) + 1;

    try {
      if (isOnline) {
        // Fetch from API
        final (total, absences) = await _remoteService.fetchAbsences(
          page: page,
          limit: limit,
          type: type,
          from: from?.toIso8601String(),
          to: to?.toIso8601String(),
        );

        // Cache deduplicated by ID
        await _localService.saveAbsences(absences.map((e) => e.toCacheModel()).toList());

        return AbsenceList(totalCount: total, absences: absences.map((e) => e.toDomain()).toList());
      } else {
        // Offline fallback: filter, paginate, count from local cache
        final cached = await _localService.getCachedAbsences();

        final filtered =
            cached.where((a) {
              final matchType = type == null || a.type == type;
              final start = DateTime.tryParse(a.startDate ?? '');
              final end = DateTime.tryParse(a.endDate ?? '');

              final matchDate =
                  (from == null || start?.isAfter(from.subtract(Duration(days: 1))) == true) &&
                  (to == null || end?.isBefore(to.add(Duration(days: 1))) == true);

              return matchType && matchDate;
            }).toList();

        final paginated = filtered.skip(offset).take(limit).toList();

        return AbsenceList(
          totalCount: filtered.length,
          absences: paginated.map((e) => e.toApiModel().toDomain()).toList(),
        );
      }
    } catch (_) {
      // Fallback if both API and local loading fail
      final fallback = await _localService.getCachedAbsences();
      return AbsenceList(
        totalCount: fallback.length,
        absences: fallback.map((e) => e.toApiModel().toDomain()).toList(),
      );
    }
  }
}
