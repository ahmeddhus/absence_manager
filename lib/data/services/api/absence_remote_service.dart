import 'package:absence_manager/core/network/http_client.dart';
import 'package:absence_manager/data/services/api/model/absence/absence_api_model.dart';

class AbsenceRemoteService {
  final HttpClient _httpClient;

  AbsenceRemoteService(this._httpClient);

  Future<(int total, List<AbsenceApiModel> items)> fetchAbsences({
    required int page,
    required int limit,
  }) async {
    final data = await _httpClient.get('/absences?page=$page&limit=$limit');

    final list = (data['data'] as List).map((json) => AbsenceApiModel.fromJson(json)).toList();

    final total = data['total'] as int;

    return (total, list);
  }
}
