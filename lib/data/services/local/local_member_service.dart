import 'package:absence_manager/config/assets.dart';
import 'package:absence_manager/data/services/api/model/member/member_api_model.dart';

import 'local_json_loader.dart';

class LocalMemberService {
  final LocalJsonLoader loader;

  const LocalMemberService(this.loader);

  Future<List<MemberApiModel>> fetchMembers() async {
    final jsonList = await loader.loadJsonArray(Assets.members);
    return jsonList.map((e) => MemberApiModel.fromJson(e)).toList();
  }
}
