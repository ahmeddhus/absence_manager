import 'package:absence_manager/config/service_locator.dart';
import 'package:absence_manager/data/services/local/model/absence/absence_cache_model.dart';
import 'package:absence_manager/data/services/local/model/member/member_cache_model.dart';
import 'package:absence_manager/ui/absence/bloc/absence_bloc.dart';
import 'package:absence_manager/ui/absence/bloc/absence_event.dart';
import 'package:absence_manager/ui/absence/widgets/absence_screen.dart';
import 'package:absence_manager/ui/app_info/bloc/app_info_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(AbsenceCacheModelAdapter());
  Hive.registerAdapter(MemberCacheModelAdapter());

  await setupLocator();

  runApp(const AbsenceManagerApp());
}

class AbsenceManagerApp extends StatelessWidget {
  const AbsenceManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Absence Manager',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<AbsencesBloc>()..add(LoadAbsences())),
          BlocProvider(create: (_) => AppInfoCubit()..loadAppInfo()),
        ],
        child: const AbsencesScreen(),
      ),
    );
  }
}
