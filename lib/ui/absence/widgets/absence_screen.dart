import 'package:absence_manager/ui/absence/bloc/absence_bloc.dart';
import 'package:absence_manager/ui/absence/bloc/absence_event.dart';
import 'package:absence_manager/ui/absence/bloc/absence_state.dart';
import 'package:absence_manager/ui/absence/widgets/absences_list.dart';
import 'package:absence_manager/ui/absence/widgets/absences_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsencesScreen extends StatelessWidget {
  const AbsencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Absences")),
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AbsencesSummary(
                  totalAbsences: state.totalCount,
                  fetchedAbsences: state.absences.length,
                ),
                Expanded(
                  child: AbsencesList(
                    absenceWithMember: state.absences,
                    hasMore: state.hasMore,
                    onLoadMore: () {
                      if (state.hasMore) {
                        context.read<AbsencesBloc>().add(
                          LoadMoreAbsences(offset: state.absences.length, limit: 10),
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          }
          return Center(child: Text("No data"));
        },
      ),
    );
  }
}
