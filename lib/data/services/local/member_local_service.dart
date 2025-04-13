import 'package:absence_manager/data/services/local/model/member/member_cache_model.dart';
import 'package:hive/hive.dart';

class MemberLocalService {
  static const String _boxName = 'member_cache';

  Future<void> saveMembers(List<MemberCacheModel> members) async {
    final box = await Hive.openBox<MemberCacheModel>(_boxName);
    await box.clear(); // Overwrite cache
    await box.addAll(members);
    await box.close();
  }

  Future<List<MemberCacheModel>> getCachedMembers() async {
    final box = await Hive.openBox<MemberCacheModel>(_boxName);
    final list = box.values.toList();
    await box.close();
    return list;
  }
}
