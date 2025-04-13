import 'package:absence_manager/domain/models/absence_with_member.dart';

/// Contract for exporting absences to a platform-specific destination (e.g., file, browser download).
/// This interface is implemented separately for web, mobile, and stub platforms.
abstract class AbsenceICalExporter {
  Future<void> export(List<AbsenceWithMember> absences);
}
