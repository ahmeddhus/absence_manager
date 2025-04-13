import 'package:absence_manager/data/services/api/model/absence/absence_api_model.dart';
import 'package:absence_manager/domain/models/absence/absence.dart';
import 'package:absence_manager/domain/models/absence/absence_type.dart';

extension AbsenceApiModelX on AbsenceApiModel {
  Absence toDomain() {
    return Absence(
      id: id,
      userId: userId,
      type: AbsenceTypeX.fromString(type),
      startDate: DateTime.tryParse(startDate ?? ''),
      endDate: DateTime.tryParse(endDate ?? ''),
      memberNote: memberNote,
      admitterNote: admitterNote,
      status: _mapStatus(status),
    );
  }

  AbsenceStatus _mapStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'confirmed':
        return AbsenceStatus.confirmed;
      case 'rejected':
        return AbsenceStatus.rejected;
      default:
        return AbsenceStatus.requested;
    }
  }
}
