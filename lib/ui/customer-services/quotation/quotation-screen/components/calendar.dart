import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/supervisor/detail-lead-supervisor/components/time_picker.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String selectedCategory = 'Follow Up';

  final List<String> categories = [
    'Follow Up',
    'Tindak Lanjut Teknis',
    'Kunjungan Lapangan',
    'Lainnya',
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: 550,
        decoration: BoxDecoration(
          color: secondary100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TableCalendar(
                    firstDay: DateTime(2000),
                    lastDay: DateTime(2100),
                    focusedDay: selectedDate,
                    selectedDayPredicate: (day) => isSameDay(day, selectedDate),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        selectedDate = DateTime(
                          selectedDay.year,
                          selectedDay.month,
                          selectedDay.day,
                        );
                      });
                    },
                    calendarFormat: CalendarFormat.month,
                    headerStyle: HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                      leftChevronPadding: EdgeInsets.zero,
                      rightChevronPadding: EdgeInsets.zero,
                      headerPadding: const EdgeInsets.symmetric( horizontal: 0),
                      titleTextStyle: TextStyle(
                        fontSize: body,
                        fontWeight: FontWeight.bold,
                        color: text400,
                      ),
                      leftChevronIcon:
                          Icon(Icons.chevron_left, color: primary400),
                      rightChevronIcon:
                          Icon(Icons.chevron_right, color: primary400),
                    ),
                    
                    calendarStyle: CalendarStyle(
                      defaultDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: secondary400,
                      ),
                      todayDecoration: BoxDecoration(
                        color: primary100,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      selectedDecoration: BoxDecoration(
                        color: primary100,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: primary400, width: 2),
                      ),
                      weekendDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: secondary400,
                      ),
                      defaultTextStyle:
                          const TextStyle(fontWeight: FontWeight.bold),
                      todayTextStyle: TextStyle(
                          color: text400, fontWeight: FontWeight.bold),
                      selectedTextStyle: TextStyle(
                          color: primary400, fontWeight: FontWeight.bold),
                      weekendTextStyle:
                          const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                

                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Due Date",
                      style: TextStyle(
                          fontSize: body, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: secondary300,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Text(
                          DateFormat('dd MMMM yyyy').format(selectedDate),
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () async {
                        final pickedTime =
                            await showCustomTimePicker(context, selectedTime);
                        if (pickedTime != null) {
                          setState(() {
                            selectedTime = pickedTime;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: secondary300,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Text(
                          'Jam: ${selectedTime.format(context)}',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Ingatkan CS Untuk:",
                      style: TextStyle(
                          fontSize: body, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.indigo[50],
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: primary400),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedCategory,
                      isExpanded: true,
                      items: categories.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: primary400),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Pengingat akan dikirim ke semua yang terhubung di card ini.",
                  style: TextStyle(color: text500, fontSize: body),
                ),
                const SizedBox(height: 14),

                // Tombol Jadwalkan
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, {
                        'selectedDate': selectedDate,
                        'selectedTime': selectedTime,
                        'selectedCategory': selectedCategory,
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary400,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    child: const Text(
                      "Jadwalkan",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: descText,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Tombol Batal
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Batal',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: text600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
