import 'package:absence_manager/data/services/local/model/absence/absence_cache_model.dart';
import 'package:hive/hive.dart';

class AbsenceLocalService {
  static const String _boxName = 'absence_cache';

  /// Save absences by using their unique ID as Hive key (avoids duplication)
  Future<void> saveAbsences(List<AbsenceCacheModel> absences) async {
    final box = await Hive.openBox<AbsenceCacheModel>(_boxName);
    for (final absence in absences) {
      if (absence.id != null) {
        await box.put(absence.id, absence);
      }
    }
    await box.close();
  }

  /// Get all cached absences (unsorted)
  Future<List<AbsenceCacheModel>> getCachedAbsences() async {
    final box = await Hive.openBox<AbsenceCacheModel>(_boxName);
    final list = box.values.toList();
    await box.close();
    return list;
  }
}
