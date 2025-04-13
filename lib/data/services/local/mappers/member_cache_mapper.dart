import 'package:absence_manager/data/services/api/model/member/member_api_model.dart';
import 'package:absence_manager/data/services/local/model/member/member_cache_model.dart';

/// Extension to convert [MemberApiModel] (from the API layer) into [MemberCacheModel] (for Hive/local caching).
extension MemberApiModelMapper on MemberApiModel {
  /// Converts an API model to a local cache model.
  MemberCacheModel toCacheModel() {
    return MemberCacheModel(userId: userId, name: name ?? '', imageUrl: image ?? '');
  }
}

/// Extension to convert [MemberCacheModel] (from Hive/local storage) back into [MemberApiModel].
extension MemberCacheModelMapper on MemberCacheModel {
  /// Converts a local cache model back into an API-compatible model.
  MemberApiModel toApiModel() {
    return MemberApiModel(userId: userId, name: name, image: imageUrl);
  }
}
