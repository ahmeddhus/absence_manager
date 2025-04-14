import 'package:absence_manager/ui/app_info/bloc/app_info_cubit.dart';
import 'package:absence_manager/ui/app_info/bloc/app_info_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoButton extends StatelessWidget {
  const InfoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppInfoCubit, AppInfoState>(
      builder: (context, state) {
        if (state is! AppInfoLoaded) return const SizedBox.shrink();

        return IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () => _showDialog(context, state.version),
        );
      },
    );
  }

  void _showDialog(BuildContext context, String version) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Row(
              children: const [
                Icon(Icons.info_outline),
                SizedBox(width: 8),
                Text('About This App'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('App: Absences Manager', style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 8),
                Text('Version: $version', style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 16),
                const Text('This app helps manage employee absences.'),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close')),
            ],
          ),
    );
  }
}
