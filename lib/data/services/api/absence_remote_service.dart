import 'package:absence_manager/config/api_config.dart';
import 'package:absence_manager/core/network/http_client.dart';
import 'package:absence_manager/data/services/api/model/absence/absence_api_model.dart';

class AbsenceRemoteService {
  final HttpClient _httpClient;

  AbsenceRemoteService(this._httpClient);

  Future<(int total, List<AbsenceApiModel>)> fetchAbsences({
    required int page,
    required int limit,
    String? type,
    String? from,
    String? to,
  }) async {
    final queryParams = {
      'page': '$page',
      'limit': '$limit',
      if (type != null) 'type': type,
      if (from != null) 'from': from,
      if (to != null) 'to': to,
    };

    final uri = Uri(path: ApiConfig.absences, queryParameters: queryParams);

    final data = await _httpClient.getUri(uri);
    final list = (data['data'] as List).map((json) => AbsenceApiModel.fromJson(json)).toList();
    final total = data['total'] as int;

    return (total, list);
  }
}
