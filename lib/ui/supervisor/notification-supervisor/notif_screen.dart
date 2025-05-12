import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/supervisor/notification-supervisor/components/appbar.dart';

class NotifScreen extends StatefulWidget {
  const NotifScreen({super.key});

  @override
  State<NotifScreen> createState() => _NotifScreenState();
}

class _NotifScreenState extends State<NotifScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child:
         Column(
          children: [
            Row(
              children: [
                Text(
                  'Review Pendaftaran CS',
                  style: TextStyle(
                    fontSize: heading2, 
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Card(
              color: secondary200,
              child:ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  "Haechan", 
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  )
                ),
                subtitle: Text("@haechanahceah"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: error100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.close, color: error400),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: success100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.check, color: success500),
                        onPressed: () {},
                      ),
                    ),
                  ],
                )
              ),
            )
          ],
        )
      )
    );
  }
}