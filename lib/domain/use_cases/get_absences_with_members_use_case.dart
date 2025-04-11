import 'package:absence_manager/data/repositories/absence/absence_repository.dart';
import 'package:absence_manager/data/repositories/member/member_repository.dart';
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

  Future<List<AbsenceWithMember>> execute() async {
    final absences = await absenceRepo.getAllAbsences();
    final members = await memberRepo.getAllMembers();

    final memberMap = {for (var m in members) m.userId: m};

    return absences.map((absence) {
      final member =
          memberMap[absence.userId] ??
          Member(
            userId: absence.userId,
            name: "Unknown",
            imageUrl: "", // or a placeholder image
          );

      return AbsenceWithMember(absence: absence, member: member);
    }).toList();
  }
}
