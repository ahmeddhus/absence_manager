import 'package:absence_manager/data/repositories/member/member_repository.dart';
import 'package:absence_manager/data/services/local/local_member_service.dart';
import 'package:absence_manager/domain/models/member/member.dart';

class MemberLocalRepository implements MemberRepository {
  final LocalMemberService service;

  MemberLocalRepository(this.service);

  @override
  Future<List<Member>> getAllMembers() async {
    final apiMembers = await service.fetchMembers();
    return apiMembers.map((dto) {
      return Member(userId: dto.userId, name: dto.name ?? '', imageUrl: dto.image ?? '');
    }).toList();
  }
}
