import 'package:absence_manager/absence_manager_app.dart';
import 'package:absence_manager/config/service_locator.dart';
import 'package:absence_manager/data/services/local/model/absence/absence_cache_model.dart';
import 'package:absence_manager/data/services/local/model/member/member_cache_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initHive();
  await setupLocator();

  runApp(const AbsenceManagerApp());
}

Future<void> _initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AbsenceCacheModelAdapter());
  Hive.registerAdapter(MemberCacheModelAdapter());
}
