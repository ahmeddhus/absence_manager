import 'package:absence_manager/domain/models/member/member.dart';

abstract class MemberRepository {
  Future<List<Member>> getAllMembers();
}
