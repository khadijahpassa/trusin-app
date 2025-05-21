// Tambahan import kalau mau pake icon dropdown (opsional)
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/state-management/date_provider.dart';
import 'package:trusin_app/ui/supervisor/detail-lead-supervisor/components/time_picker.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime SelectedDate = DateTime.now();
  TimeOfDay SelectedTime = TimeOfDay.now();
  String SelectedCategory = 'Follow Up';

  final List<String> categories = [
    'Follow Up',
    'Kirim Invoice',
    'Kirim Quotation',
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: 700,
        decoration: BoxDecoration(
          color: secondary100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat('MMMM yyyy').format(SelectedDate),
                  style: TextStyle(
                    fontSize: body,
                    fontWeight: FontWeight.bold,
                    color: text400,
                  ),
                ),
                const SizedBox(height: 8),
                TableCalendar(
                  firstDay: DateTime(2000),
                  lastDay: DateTime(2100),
                  focusedDay: SelectedDate,
                  selectedDayPredicate: (day) =>
                      isSameDay(day, SelectedDate),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      SelectedDate = DateTime(
                        selectedDay.year,
                        selectedDay.month,
                        selectedDay.day,
                      );
                    });
                  },
                  calendarFormat: CalendarFormat.month,
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
                      border: Border.all(
                        color: primary400,
                        width: 2,
                      ),
                    ),
                    weekendDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: secondary400,
                    ),
                    defaultTextStyle:
                        const TextStyle(fontWeight: FontWeight.bold),
                    todayTextStyle:
                        TextStyle(color: text400, fontWeight: FontWeight.bold),
                    selectedTextStyle: TextStyle(
                        color: primary400, fontWeight: FontWeight.bold),
                    weekendTextStyle:
                        const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Due Date",
                    style:
                        TextStyle(fontSize: body, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: secondary300,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Text(
                        DateFormat('dd MMMM yyyy').format(SelectedDate),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () async {
                        final pickedTime = await showCustomTimePicker(
                            context, SelectedTime);
                        if (pickedTime != null) {
                          setState(() {
                            SelectedTime = pickedTime;
                          });
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: secondary300,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Text(
                          'Jam : ${SelectedTime.format(context)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Ingatkan CS Untuk:",
                    style:
                        TextStyle(fontSize: body, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.indigo[50],
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: primary400),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: SelectedCategory,
                      isExpanded: true,
                      items: categories
                          .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primary400,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          SelectedCategory = value!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Pengingat akan dikirim ke semua yang terhubung di card ini. ",
                    style: TextStyle(
                        color: text500,
                        fontSize: body,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<DateProvider>().setSelectedDate(SelectedDate);
                      context.read<DateProvider>().setSelectedTime(SelectedTime);
                      context.read<DateProvider>().setSelectedCategory(SelectedCategory);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primary400,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6))),
                    child: const Text(
                      "Jadwalkan",
                      style: TextStyle(
                          color: secondary100,
                          fontSize: descText,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Batal',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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
