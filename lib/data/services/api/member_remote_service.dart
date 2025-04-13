import 'package:absence_manager/config/api_config.dart';
import 'package:absence_manager/core/network/http_client.dart';
import 'package:absence_manager/data/services/api/model/member/member_api_model.dart';

class MemberRemoteService {
  final HttpClient _httpClient;

  MemberRemoteService(this._httpClient);

  Future<List<MemberApiModel>> fetchMembers() async {
    final data = await _httpClient.get(ApiConfig.members);

    if (data is List) {
      return data.map((json) => MemberApiModel.fromJson(json)).toList();
    } else {
      throw FormatException('Unexpected data format for /members');
    }
  }
}
