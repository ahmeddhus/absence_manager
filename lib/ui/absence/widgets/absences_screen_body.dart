import 'package:absence_manager/ui/absence/bloc/absence_bloc.dart';
import 'package:absence_manager/ui/absence/bloc/absence_event.dart';
import 'package:absence_manager/ui/absence/bloc/absence_state.dart';
import 'package:absence_manager/ui/absence/widgets/absence_filter_section.dart';
import 'package:absence_manager/ui/absence/widgets/absence_tile.dart';
import 'package:absence_manager/ui/absence/widgets/absences_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsencesScreenBody extends StatelessWidget {
  final AbsencesLoaded state;

  const AbsencesScreenBody({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AbsencesSummary(
              totalAbsences: state.totalCount,
              fetchedAbsences: state.absences.length,
            ),
            AbsenceFilterSection(
              selectedType: state.selectedType,
              selectedRange: state.selectedDateRange,
              onTypeChanged: (type) {
                context.read<AbsencesBloc>().add(
                  LoadAbsences(type: type, dateRange: state.selectedDateRange),
                );
              },
              onDateRangeChanged: (range) {
                context.read<AbsencesBloc>().add(
                  LoadAbsences(type: state.selectedType, dateRange: range),
                );
              },
            ),
            Expanded(
              child:
                  state.isInitialLoading
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                        itemCount: state.absences.length + (state.hasMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == state.absences.length && state.hasMore) {
                            // Load More Button
                            return SafeArea(
                              child: Container(
                                margin: EdgeInsets.only(top: 16),
                                child: Center(
                                  child:
                                      state.isLoadingMore
                                          ? CircularProgressIndicator()
                                          : ElevatedButton(
                                            onPressed: () {
                                              if (state.hasMore) {
                                                context.read<AbsencesBloc>().add(
                                                  LoadMoreAbsences(
                                                    offset: state.absences.length,
                                                    limit: 10,
                                                  ),
                                                );
                                              }
                                            },
                                            child: Text("Load More"),
                                          ),
                                ),
                              ),
                            );
                          }

                          return AbsenceTile(data: state.absences[index]);
                        },
                      ),
            ),
          ],
        ),

        if (state.isExporting)
          Container(
            color: colorScheme.onSurface.withValues(alpha: 0.3),
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
