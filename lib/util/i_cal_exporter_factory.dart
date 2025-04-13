export 'package:absence_manager/data/services/export/stub_absence_i_cal_exporter.dart'
    if (dart.library.html) 'package:absence_manager/data/services/export/web_absence_i_cal_exporter.dart'
    if (dart.library.io) 'package:absence_manager/data/services/export/mobile_absence_i_cal_exporter.dart';

/// Conditionally exports the platform-specific implementation of [AbsenceExporter].
///
/// - On Web: uses [WebAbsenceICalExporter] to trigger browser file download
/// - On Mobile/Desktop: uses [MobileAbsenceICalExporter] to generate and share a file
/// - Fallback: uses [StubAbsenceICalExporter] which throws an error for unsupported platforms
///
/// This allows the app to inject the correct exporter without platform checks in the BLoC or UI.
