import 'package:absence_manager/domain/models/absence_with_member.dart';
import 'package:absence_manager/ui/absence/widgets/absence_tile.dart';
import 'package:flutter/material.dart';

class AbsencesList extends StatelessWidget {
  final List<AbsenceWithMember> absenceWithMember;
  final bool hasMore;
  final VoidCallback onLoadMore;

  const AbsencesList({
    super.key,
    required this.absenceWithMember,
    required this.hasMore,
    required this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: absenceWithMember.length + (hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == absenceWithMember.length && hasMore) {
          // Load More Button
          return SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: 16),
              child: Center(child: ElevatedButton(onPressed: onLoadMore, child: Text("Load More"))),
            ),
          );
        }

        return AbsenceTile(data: absenceWithMember[index]);
      },
    );
  }
}
