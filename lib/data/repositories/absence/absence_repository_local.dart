import 'package:absence_manager/data/repositories/absence/absence_repository.dart';
import 'package:absence_manager/data/services/local/local_absence_service.dart';
import 'package:absence_manager/domain/models/absence/absence.dart';

class AbsenceLocalRepository implements AbsenceRepository {
  final LocalAbsenceService service;

  AbsenceLocalRepository(this.service);

  @override
  Future<List<Absence>> getAllAbsences({int offset = 0, int limit = 10}) async {
    final apiAbsences = await service.fetchAbsences();
    return apiAbsences
        .map((dto) {
          final status =
              dto.confirmedAt != null
                  ? AbsenceStatus.confirmed
                  : dto.rejectedAt != null
                  ? AbsenceStatus.rejected
                  : AbsenceStatus.requested;

          return Absence(
            id: dto.id ?? -1,
            userId: dto.userId ?? -1,
            type: dto.type ?? '',
            startDate: DateTime.tryParse(dto.startDate ?? '') ?? DateTime(1970),
            endDate: DateTime.tryParse(dto.endDate ?? '') ?? DateTime(1970),
            memberNote: dto.memberNote?.trim().isEmpty ?? true ? null : dto.memberNote,
            admitterNote: dto.admitterNote?.trim().isEmpty ?? true ? null : dto.admitterNote,
            status: status,
          );
        })
        .skip(offset)
        .take(limit)
        .toList();
  }
}
