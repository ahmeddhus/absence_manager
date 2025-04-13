import 'package:absence_manager/data/services/api/model/absence/absence_api_model.dart';
import 'package:absence_manager/data/services/local/model/absence/absence_cache_model.dart';

/// Extension to convert [AbsenceApiModel] (from the API layer) into [AbsenceCacheModel] (for Hive/local caching).
extension AbsenceApiModelMapper on AbsenceApiModel {
  /// Converts an API model to a cache model.
  AbsenceCacheModel toCacheModel() {
    return AbsenceCacheModel()
      ..id = id
      ..userId = userId
      ..type = type
      ..startDate = startDate
      ..endDate = endDate
      ..memberNote = memberNote
      ..admitterNote = admitterNote
      ..status = status;
  }
}

/// Extension to convert [AbsenceCacheModel] (from Hive/local cache) back into [AbsenceApiModel] (compatible with domain layer).
extension AbsenceCacheModelMapper on AbsenceCacheModel {
  /// Converts a cache model back to the original API model.
  AbsenceApiModel toApiModel() {
    return AbsenceApiModel(
      id: id,
      userId: userId,
      type: type,
      startDate: startDate,
      endDate: endDate,
      memberNote: memberNote,
      admitterNote: admitterNote,
      status: status,
    );
  }
}
