import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

Future<TimeOfDay?> showCustomTimePicker(BuildContext context, TimeOfDay initialTime) {
  TimeOfDay selectedTime = initialTime;

  return showDialog<TimeOfDay>(
    context: context,
    builder: (context) {
      int selectedHour = selectedTime.hour;
      int selectedMinute = selectedTime.minute;

      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: secondary100,
        title: const Text("Pilih Jam"),
        content: SizedBox(
          height: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // HOUR
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 40,
                  perspective: 0.005,
                  diameterRatio: 1.2,
                  physics: FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    selectedHour = index;
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) => Center(
                      child: Text(index.toString().padLeft(2, '0'),
                          style: TextStyle(fontSize: 18, color: text400)),
                    ),
                    childCount: 24,
                  ),
                ),
              ),
              const Text(
                ":", 
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                )
              ),
              // MINUTE
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 40,
                  perspective: 0.005,
                  diameterRatio: 1.2,
                  physics: FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    selectedMinute = index;
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) => Center(
                      child: Text(index.toString().padLeft(2, '0'),
                          style: TextStyle(fontSize: 18, color: text400)),
                    ),
                    childCount: 60,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal", style: TextStyle(color: Colors.grey[600])),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primary400),
            onPressed: () {
              Navigator.pop(context, TimeOfDay(hour: selectedHour, minute: selectedMinute));
            },
            child: const Text(
              "Pilih",
              style: TextStyle(
                color: secondary100
              ),
            ),
          ),
        ],
      );
    },
  );
}
