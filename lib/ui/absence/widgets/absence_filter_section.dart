import 'package:absence_manager/domain/models/absence/absence_type.dart';
import 'package:flutter/material.dart';

class AbsenceFilterSection extends StatelessWidget {
  final AbsenceType? selectedType;
  final DateTimeRange? selectedRange;
  final void Function(AbsenceType?) onTypeChanged;
  final void Function(DateTimeRange?) onDateRangeChanged;

  const AbsenceFilterSection({
    super.key,
    required this.selectedType,
    required this.selectedRange,
    required this.onTypeChanged,
    required this.onDateRangeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<AbsenceType?>(
            value: selectedType,
            decoration: InputDecoration(labelText: "Type"),
            items: [
              const DropdownMenuItem(value: null, child: Text("All")),
              ...AbsenceType.values.map(
                (type) => DropdownMenuItem(value: type, child: Text(type.label)),
              ),
            ],
            onChanged: onTypeChanged,
            isExpanded: true,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final now = DateTime.now();
                    final picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(now.year - 5),
                      lastDate: DateTime(now.year + 5),
                      initialDateRange: selectedRange,
                    );
                    if (picked != null) {
                      onDateRangeChanged(picked);
                    }
                  },
                  icon: const Icon(Icons.date_range),
                  label: Text(
                    selectedRange == null
                        ? "Select Date Range"
                        : "${selectedRange?.start.toLocal().toShortString()} → ${selectedRange?.end.toLocal().toShortString()}",
                  ),
                ),
              ),
              if (selectedRange != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: TextButton.icon(
                    onPressed: () => onDateRangeChanged(null),
                    icon: const Icon(Icons.clear),
                    label: const Text("Clear"),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

extension on DateTime {
  String toShortString() =>
      "${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year";
}
