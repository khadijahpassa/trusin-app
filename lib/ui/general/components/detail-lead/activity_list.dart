import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

class ActivityList extends StatelessWidget {
  const ActivityList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> activities = [
      {
        'name': 'Hajjah',
        'action': 'mengubah stage',
        'detail': 'Stage: Send Quotation → Won',
        'date': 'Feb 28, 12:30 PM',
      },
      {
        'name': 'Amirul',
        'action': 'menjadwalkan ulang',
        'detail': 'Time: Follow Up: Feb 23, 2:30PM',
        'date': 'Feb 23, 8:30 AM',
      },
      {
        'name': 'Hajjah',
        'action': 'membuat leads',
        'detail': 'bnml',
        'date': 'Feb 17, 2:30 PM',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: Colors.black,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Aktivitas',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primary100,
                foregroundColor: primary400,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      6), // kecilin radius biar agak kotak
                ),
                elevation: 0, // kalo mau flat, gak ngangkat
              ),
              child: const Text(
                'Lebih sedikit',
                style: TextStyle(
                  fontSize: body,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 20),
        ...activities.map((activity) {
          //spread operator, buat masukin list kecil ke list besar, ini list activity masuk ke children yg notabenya adalah list
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[300],
                  child: Text(
                    activity['name']![0],
                    style: TextStyle(fontWeight: FontWeight.bold,),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: activity['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: descText
                              ),
                            ),
                            TextSpan(
                              text: ' ${activity['action']}',
                            ),
                          ],
                        ),
                      ),
                      if (activity['detail']!.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            activity['detail']!,
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                ),
                Text(
                  activity['date']!,
                  style: TextStyle(
                    color: primary600,
                    fontSize: caption,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          );
        })//.toList(), ini gatau gunanya apa, soalnya dihapus pun ga ngaruh
      ],
    );
  }
}
