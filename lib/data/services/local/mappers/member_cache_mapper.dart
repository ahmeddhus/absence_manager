import 'package:absence_manager/data/services/api/model/member/member_api_model.dart';
import 'package:absence_manager/data/services/local/model/member/member_cache_model.dart';

extension MemberApiModelMapper on MemberApiModel {
  MemberCacheModel toCacheModel() {
    return MemberCacheModel(userId: userId, name: name ?? '', imageUrl: image ?? '');
  }
}

extension MemberCacheModelMapper on MemberCacheModel {
  MemberApiModel toApiModel() {
    return MemberApiModel(userId: userId, name: name, image: imageUrl);
  }
}
