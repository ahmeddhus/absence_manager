import 'package:absence_manager/ui/absence/bloc/absence_bloc.dart';
import 'package:absence_manager/ui/absence/bloc/absence_state.dart';
import 'package:absence_manager/ui/absence/widgets/absences_screen_body.dart';
import 'package:absence_manager/ui/absence/widgets/export_fab_button.dart';
import 'package:absence_manager/ui/app_info/widgets/info_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsencesScreen extends StatelessWidget {
  const AbsencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Absences Manager'), actions: [InfoButton()]),

      floatingActionButton: ExportFabButton(),
      body: BlocBuilder<AbsencesBloc, AbsencesState>(
        builder: (context, state) {
          if (state is AbsencesLoaded) {
            return AbsencesScreenBody(state: state);
          } else if (state is AbsencesError) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(child: Text("Error: ${state.message}", textAlign: TextAlign.center)),
            );
          }
          return Center(child: Text("No data"));
        },
      ),
    );
  }
}
