import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/state-management/date_provider.dart';
import 'package:trusin_app/ui/supervisor/detail-lead-supervisor/components/calendar.dart';

class Date extends StatelessWidget {
  const Date({super.key});

  void _pickDateTime(BuildContext context) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => const Calendar(),
    );

    if (result != null) {
      final dateProvider = context.read<DateProvider>();
      dateProvider.setSelectedDate(result['selectedDate']);
      dateProvider.setSelectedTime(result['selectedTime']);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateProvider = context.watch<DateProvider>();
    final selectedDate = dateProvider.selectedDate ?? DateTime.now();
    final selectedTime = dateProvider.selectedTime ?? TimeOfDay.now();



    // Gabung tanggal + jam ke satu DateTime
    final combinedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    final formattedDate = DateFormat('MMM d, h:mm a').format(combinedDateTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Due Date',
              style: TextStyle(
                fontSize: caption,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              decoration: BoxDecoration(
                color: primary500,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Overdue',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: caption,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        InkWell(
          onTap: () => _pickDateTime(context),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.indigo[50],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: body,
                    color: Colors.indigo[900],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
