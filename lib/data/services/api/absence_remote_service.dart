import 'package:absence_manager/core/network/http_client.dart';
import 'package:absence_manager/data/services/api/model/absence/absence_api_model.dart';

class AbsenceRemoteService {
  final HttpClient _httpClient;

  AbsenceRemoteService(this._httpClient);

  Future<List<AbsenceApiModel>> fetchAbsences() async {
    final response = await _httpClient.get('/absences');

    final data = response['data'];
    if (data is List) {
      return data.map((json) => AbsenceApiModel.fromJson(json)).toList();
    } else {
      throw FormatException('Unexpected data format for /absences');
    }
  }
}
