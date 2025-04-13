import 'package:absence_manager/config/assets.dart';
import 'package:absence_manager/data/services/api/model/absence/absence_api_model.dart';

import 'local_json_loader.dart';

class LocalAbsenceService {
  final LocalJsonLoader loader;

  const LocalAbsenceService(this.loader);

  Future<List<AbsenceApiModel>> fetchAbsences() async {
    final jsonList = await loader.loadJsonArray(Assets.absences);
    return jsonList.map((e) => AbsenceApiModel.fromJson(e)).toList();
  }
}
