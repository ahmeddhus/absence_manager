import 'package:absence_manager/domain/models/absence/absence.dart';

class AbsenceList {
  final int totalCount;
  final List<Absence> absences;

  AbsenceList({required this.totalCount, required this.absences});
}
