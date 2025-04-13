import 'package:absence_manager/data/services/local/model/absence/absence_cache_model.dart';
import 'package:hive/hive.dart';

class AbsenceLocalService {
  static const String _boxName = 'absence_cache';

  Future<void> saveAbsences(List<AbsenceCacheModel> absences) async {
    final box = await Hive.openBox<AbsenceCacheModel>(_boxName);
    await box.clear(); // Overwrite cache
    await box.addAll(absences);
    await box.close();
  }

  Future<List<AbsenceCacheModel>> getCachedAbsences() async {
    final box = await Hive.openBox<AbsenceCacheModel>(_boxName);
    final list = box.values.toList();
    await box.close();
    return list;
  }
}
