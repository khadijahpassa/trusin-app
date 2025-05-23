import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/lead_list_controller.dart';
import 'package:trusin_app/ui/supervisor/detail-lead-supervisor/components/calendar.dart';

class Date extends StatelessWidget {
  final String leadId;
  final void Function(DateTime date, TimeOfDay time)? onDateChanged;

  const Date({super.key, this.onDateChanged, required this.leadId});

  void _pickDateTime(BuildContext context) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => Calendar(leadId: leadId),
    );

    if (result != null && onDateChanged != null) {
      final selectedDate = result['selectedDate'] as DateTime;
      final selectedTime = result['selectedTime'] as TimeOfDay;

      onDateChanged!(selectedDate, selectedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LeadListController>();
    controller.streamLeadById(leadId);
    
    return Obx(() {
      final lead = controller.selectedLead.value;

      if (lead == null) {
        return const Text("Loading...");
      }

      final reminderDate = lead.reminderDate ?? DateTime.now();
      final formattedDate = DateFormat('MMM d, h:mm a').format(reminderDate);

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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
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
    });
  }
}
