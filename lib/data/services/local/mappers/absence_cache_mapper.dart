import 'package:absence_manager/data/services/api/model/absence/absence_api_model.dart';
import 'package:absence_manager/data/services/local/model/absence/absence_cache_model.dart';

extension AbsenceApiModelMapper on AbsenceApiModel {
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

extension AbsenceCacheModelMapper on AbsenceCacheModel {
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
