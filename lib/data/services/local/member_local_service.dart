import 'package:absence_manager/data/services/local/model/member/member_cache_model.dart';
import 'package:hive/hive.dart';

class MemberLocalService {
  static const String _boxName = 'member_cache';

  /// Save members by their userId as key to avoid duplication
  Future<void> saveMembers(List<MemberCacheModel> members) async {
    final box = await Hive.openBox<MemberCacheModel>(_boxName);
    for (final member in members) {
      if (member.userId != null) {
        await box.put(member.userId, member);
      }
    }
    await box.close();
  }

  /// Get all cached members
  Future<List<MemberCacheModel>> getCachedMembers() async {
    final box = await Hive.openBox<MemberCacheModel>(_boxName);
    final list = box.values.toList();
    await box.close();
    return list;
  }
}
