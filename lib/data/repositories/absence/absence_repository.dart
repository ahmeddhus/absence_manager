import 'package:absence_manager/domain/models/absence/absence.dart';

abstract class AbsenceRepository {
  Future<List<Absence>> getAllAbsences();
}
