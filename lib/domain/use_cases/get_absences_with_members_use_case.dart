import 'package:absence_manager/data/repositories/absence/absence_repository.dart';
import 'package:absence_manager/data/repositories/member/member_repository.dart';
import 'package:absence_manager/domain/models/absence_list_with_members.dart';
import 'package:absence_manager/domain/models/absence_with_member.dart';
import 'package:absence_manager/domain/models/member/member.dart';

/// Use case for retrieving all absences enriched with their corresponding member data.
///
/// Loads absence and member data from their respective repositories, then
/// joins them by `userId`. The resulting list contains `AbsenceWithMember` objects,
/// which are ready for display in the UI.
///
/// This logic belongs in the domain layer as it represents business rules,
/// not raw data fetching or UI formatting.

class GetAbsencesWithMembersUseCase {
  final AbsenceRepository _absenceRepository;
  final MemberRepository _memberRepository;

  GetAbsencesWithMembersUseCase({
    required AbsenceRepository absenceRepository,
    required MemberRepository memberRepository,
  }) : _absenceRepository = absenceRepository,
       _memberRepository = memberRepository;

  Future<AbsenceListWithMembers> call({required int offset, required int limit}) async {
    final absenceList = await _absenceRepository.getAllAbsences(offset: offset, limit: limit);
    final members = await _memberRepository.getAllMembers();

    final membersMap = {for (final m in members) m.userId: m};

    final combined =
        absenceList.absences.map((absence) {
          final member =
              membersMap[absence.userId] ??
              Member(userId: absence.userId, name: 'Unknown', imageUrl: '');
          return AbsenceWithMember(absence: absence, member: member);
        }).toList();

    return AbsenceListWithMembers(totalCount: absenceList.totalCount, absences: combined);
  }
}
