import 'package:absence_manager/domain/models/absence/absence_type.dart';
import 'package:absence_manager/domain/models/absence_with_member.dart';
import 'package:flutter/material.dart';

class AbsenceTile extends StatelessWidget {
  final AbsenceWithMember data;

  const AbsenceTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final absence = data.absence;
    final member = data.member;

    return ListTile(
      leading: CircleAvatar(
        backgroundImage:
            data.member.imageUrl.isNotEmpty ? NetworkImage(data.member.imageUrl) : null,
        child: data.member.imageUrl.isEmpty ? const Icon(Icons.person_outline) : null,
      ),

      title: Text(member.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Type: ${absence.type?.label}"),
          Text("Period: ${_formatDate(absence.startDate)} → ${_formatDate(absence.endDate)}"),
          if (absence.memberNote?.isNotEmpty ?? false) Text("Member note: ${absence.memberNote}"),
          if (absence.admitterNote?.isNotEmpty ?? false)
            Text("Admitter note: ${absence.admitterNote}"),
          Text("Status: ${absence.status.name}"),
        ],
      ),
      isThreeLine: true,
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}
