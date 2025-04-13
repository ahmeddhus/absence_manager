export 'package:absence_manager/data/services/export/stub_absence_i_cal_exporter.dart'
    if (dart.library.html) 'package:absence_manager/data/services/export/web_absence_i_cal_exporter.dart'
    if (dart.library.io) 'package:absence_manager/data/services/export/mobile_absence_i_cal_exporter.dart';
