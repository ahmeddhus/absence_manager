import 'package:absence_manager/data/services/api/model/member/member_api_model.dart';
import 'package:absence_manager/domain/models/member/member.dart';

/// Extension to convert [MemberApiModel] from the data/API layer into a domain-level [Member] entity.
extension MemberApiModelX on MemberApiModel {
  /// Converts an API model into a pure Dart domain model.
  Member toDomain() {
    return Member(userId: userId, name: name ?? '', imageUrl: image ?? '');
  }
}
