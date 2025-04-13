import 'package:absence_manager/ui/absence/bloc/absence_bloc.dart';
import 'package:absence_manager/ui/absence/bloc/absence_event.dart';
import 'package:absence_manager/ui/absence/bloc/absence_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExportFabButton extends StatelessWidget {
  const ExportFabButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbsencesBloc, AbsencesState>(
      builder: (context, state) {
        final bool isEnabled = state is AbsencesLoaded && state.absences.isNotEmpty;
        final colorScheme = Theme.of(context).colorScheme;

        final backgroundColor =
            isEnabled ? colorScheme.primaryContainer : colorScheme.primaryContainer;
        final icon = kIsWeb ? Icons.download : Icons.share;
        final iconColor =
            isEnabled ? colorScheme.primary : colorScheme.primary.withValues(alpha: 0.3);

        return FloatingActionButton(
          onPressed:
              isEnabled
                  ? () {
                    context.read<AbsencesBloc>().add(
                      ExportAbsencesToICal(
                        onExportResult:
                            (message) => ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(SnackBar(content: Text(message))),
                      ),
                    );
                  }
                  : null,
          backgroundColor: backgroundColor,
          child: Icon(icon, color: iconColor),
        );
      },
    );
  }
}
