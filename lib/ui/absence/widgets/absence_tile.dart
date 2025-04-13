import 'package:absence_manager/domain/models/absence/absence_type.dart';
import 'package:absence_manager/domain/models/absence_with_member.dart';
import 'package:flutter/material.dart';

class AbsenceTile extends StatelessWidget {
  final AbsenceWithMember data;

  const AbsenceTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final absence = data.absence;
    final member = data.member;

    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: colorScheme.primaryContainer,
        child: ClipOval(
          child: Image.network(
            data.member.imageUrl,
            fit: BoxFit.cover,
            width: 48,
            height: 48,
            errorBuilder: (_, __, ___) => const Icon(Icons.person),
          ),
        ),
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
