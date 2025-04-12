import 'package:absence_manager/ui/absence/bloc/absence_bloc.dart';
import 'package:absence_manager/ui/absence/bloc/absence_event.dart';
import 'package:absence_manager/ui/absence/bloc/absence_state.dart';
import 'package:absence_manager/ui/absence/widgets/absences_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

class AbsencesScreen extends StatelessWidget {
  const AbsencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Absences")),
      floatingActionButton: BlocBuilder<AbsencesBloc, AbsencesState>(
        builder: (context, state) {
          final bool isEnabled = state is AbsencesLoaded && state.absences.isNotEmpty;
          final colorScheme = Theme.of(context).colorScheme;

          return FloatingActionButton(
            onPressed:
                isEnabled
                    ? () {
                      context.read<AbsencesBloc>().add(
                        ExportAbsencesToICal(
                          onExportSuccess: (filePath) => Share.shareXFiles([XFile(filePath)]),
                          onExportError: (error) {
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(SnackBar(content: Text(error)));
                          },
                        ),
                      );
                    }
                    : null,
            backgroundColor:
                isEnabled ? colorScheme.primaryContainer : colorScheme.primaryContainer,
            child: Icon(
              Icons.share,
              color: isEnabled ? colorScheme.primary : colorScheme.primary.withValues(alpha: 0.3),
            ),
          );
        },
      ),
      body: BlocBuilder<AbsencesBloc, AbsencesState>(
        builder: (context, state) {
          if (state is AbsencesLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AbsencesError) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(child: Text("Error: ${state.message}", textAlign: TextAlign.center)),
            );
          } else if (state is AbsencesLoaded) {
            return AbsencesScreenBody(state: state);
          }
          return Center(child: Text("No data"));
        },
      ),
    );
  }
}
