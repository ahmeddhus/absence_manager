import 'package:absence_manager/data/services/api/model/absence/absence_api_model.dart';
import 'package:absence_manager/domain/models/absence/absence.dart';
import 'package:absence_manager/domain/models/absence/absence_type.dart';

/// Extension to convert [AbsenceApiModel] from the data/API layer into a domain-level [Absence] entity.
extension AbsenceApiModelX on AbsenceApiModel {
  /// Converts an [AbsenceApiModel] to a [Absence] used in the domain layer.
  Absence toDomain() {
    return Absence(
      id: id,
      userId: userId,
      type: AbsenceTypeX.fromString(type), // Safely convert string to enum
      startDate: DateTime.tryParse(startDate ?? ''),
      endDate: DateTime.tryParse(endDate ?? ''),
      memberNote: memberNote,
      admitterNote: admitterNote,
      status: _mapStatus(status),
    );
  }

  /// Maps the status string from the API to a typed [AbsenceStatus] enum.
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
