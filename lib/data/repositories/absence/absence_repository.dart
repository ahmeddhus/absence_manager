import 'package:absence_manager/domain/models/absence/absence_list.dart';

abstract class AbsenceRepository {
  Future<AbsenceList> getAllAbsences({
    required int offset,
    required int limit,
    String? type,
    DateTime? from,
    DateTime? to,
  });
}
