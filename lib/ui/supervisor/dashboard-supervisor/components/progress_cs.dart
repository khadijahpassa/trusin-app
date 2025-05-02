import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

class ProgressCS extends StatelessWidget {
  const ProgressCS({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lihat Progress CS',
          style: TextStyle(fontSize: heading2, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          height: 400,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: primary100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Ketik nama CS...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildCSCard(context, 'Hajjah Mecca', '16 New Customer | 10 Won', '/assets/images/role_cs.png'),
                      SizedBox(height: 5),
                      _buildCSCard(context, 'Agung Gunawan', '16 New Customer | 10 Won', '/assets/images/role_supervisor.png'),
                      SizedBox(height: 5),
                      _buildCSCard(context, 'Nisbar Membara', '16 New Customer | 10 Won', '/assets/images/waiting_approval.png'),
                      SizedBox(height: 5),
                      _buildCSCard(context, 'Nisbar Membara', '16 New Customer | 10 Won', '/assets/images/waiting_approval.png'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCSCard(BuildContext context, String name, String details, String avatar) {
    return Card(
      color: secondary100,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(avatar),
        ),
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(details),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary400,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/detailcs');
          },
          child: Text(
            'Detail',
            style: TextStyle(
            color: text100,
            fontSize: body
          ),
        ),
        ),
      ),
    );
  }
}
