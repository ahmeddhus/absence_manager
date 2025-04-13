import 'package:absence_manager/data/services/api/model/member/member_api_model.dart';
import 'package:absence_manager/domain/models/member/member.dart';

extension MemberApiModelX on MemberApiModel {
  Member toDomain() {
    return Member(userId: userId, name: name ?? '', imageUrl: image ?? '');
  }
}
