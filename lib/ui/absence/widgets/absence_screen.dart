import 'package:absence_manager/ui/absence/bloc/absence_bloc.dart';
import 'package:absence_manager/ui/absence/bloc/absence_state.dart';
import 'package:absence_manager/ui/absence/widgets/absence_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsencesScreen extends StatelessWidget {
  const AbsencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Absences")),
      body: BlocBuilder<AbsencesBloc, AbsencesState>(
        builder: (context, state) {
          if (state is AbsencesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AbsencesLoaded) {
            if (state.absences.isEmpty) {
              return const Center(child: Text("No absences found."));
            }
            return ListView.builder(
              itemCount: state.absences.length,
              itemBuilder: (context, index) {
                final absenceWithMember = state.absences[index];
                return AbsenceTile(data: absenceWithMember);
              },
            );
          } else if (state is AbsencesError) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(child: Text("Error: ${state.message}", textAlign: TextAlign.center)),
            );
          }
          return const SizedBox.shrink(); // AbsencesInitial
        },
      ),
    );
  }
}
