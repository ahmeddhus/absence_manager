import 'package:flutter/material.dart';

class AbsencesSummary extends StatelessWidget {
  final int totalAbsences;
  final int fetchedAbsences;

  const AbsencesSummary({super.key, required this.totalAbsences, required this.fetchedAbsences});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Absences",
                    style: TextStyle(fontSize: 14, color: colorScheme.secondary),
                  ),
                  Text(
                    "$totalAbsences",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Fetched", style: TextStyle(fontSize: 14, color: colorScheme.secondary)),
                  Text(
                    "$fetchedAbsences",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
