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
  final AbsenceRepository absenceRepo;
  final MemberRepository memberRepo;

  GetAbsencesWithMembersUseCase(this.absenceRepo, this.memberRepo);

  Future<AbsenceListWithMembers> execute({int offset = 0, int limit = 10}) async {
    final absenceList = await absenceRepo.getAllAbsences(offset: offset, limit: limit);
    final members = await memberRepo.getAllMembers();

    // Create a map of userId to Member for quick lookup
    final memberMap = {for (var m in members) m.userId: m};

    // Combine absences with corresponding members
    final absencesWithMembers =
        absenceList.absences.map((absence) {
          final member =
              memberMap[absence.userId] ??
              Member(userId: absence.userId, name: "Unknown", imageUrl: "");
          return AbsenceWithMember(absence: absence, member: member);
        }).toList();

    // Return totalCount and combined absences
    return AbsenceListWithMembers(
      totalCount: absenceList.totalCount,
      absences: absencesWithMembers,
    );
  }
}
