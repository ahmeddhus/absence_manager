import 'package:absence_manager/config/service_locator.dart';
import 'package:absence_manager/ui/absence/bloc/absence_bloc.dart';
import 'package:absence_manager/ui/absence/bloc/absence_event.dart';
import 'package:absence_manager/ui/absence/widgets/absence_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      home: BlocProvider(
        create: (_) => sl<AbsencesBloc>()..add(LoadAbsences()),
        child: const AbsencesScreen(),
      ),
    );
  }
}
