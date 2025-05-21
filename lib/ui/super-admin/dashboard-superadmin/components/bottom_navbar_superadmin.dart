import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/super-admin/companies/companies_superadmin.dart';
import 'package:trusin_app/ui/super-admin/dashboard-superadmin/dashboard_superadmin.dart';
import 'package:trusin_app/ui/super-admin/notification-superadmin/notification_superadmin.dart';
import 'package:trusin_app/ui/super-admin/verify/verify_superadmin.dart';

class BottomNavbarSuperadmin extends StatefulWidget {
  const BottomNavbarSuperadmin({super.key});

  @override
  State<BottomNavbarSuperadmin> createState() => _BottomNavbarSuperadminState();
}

class _BottomNavbarSuperadminState extends State<BottomNavbarSuperadmin> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navigasi ke halaman sesuai index
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: 
        (context) => NotificationSuperadmin()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: 
        (context) => VerifySuperadmin()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: 
        (context) => NotificationSuperadmin()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: 
        (context) => CompaniesSuperadmin()));
        break;
    }
  } 
  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth / 4; // Karena ada 4 item
    return Scaffold(
      body: IndexedStack(
      index: _selectedIndex,
      children: [
        DashboardSuperadmin(),
        VerifySuperadmin(),
        CompaniesSuperadmin(),
        NotificationSuperadmin(),
        // Tambahkan halaman lain sesuai kebutuhan
      ],
    ),
      bottomNavigationBar: Stack(
        alignment: Alignment.topCenter,
        children: [
          BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: _selectedIndex,
            selectedItemColor: primary500,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            onTap: (int newIndex) {
              setState(() {
                _selectedIndex = newIndex;
              });
            }, 
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/home.svg',
                  colorFilter: ColorFilter.mode( _selectedIndex == 0 ? primary500 : Colors.grey, BlendMode.srcIn),
                ),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/check.svg',
                  colorFilter: ColorFilter.mode( _selectedIndex == 1 ? primary500 : Colors.grey, BlendMode.srcIn),
                ),
                label: 'Verify'
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/building.svg',
                  colorFilter: ColorFilter.mode( _selectedIndex == 2 ? primary500 : Colors.grey, BlendMode.srcIn),
                ),
                label: 'Companies'
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/notification.svg',
                  colorFilter: ColorFilter.mode( _selectedIndex == 3 ? primary500 : Colors.grey, BlendMode.srcIn),
                ),
                label: 'Notification'
              ),
            ]
          ),
          Positioned(
            left: itemWidth * _selectedIndex + itemWidth / 6, // Pusatkan ke ikon aktif
            child: Column( // Atur lebar container
              children: [
                Stack(
                  alignment: AlignmentDirectional.topCenter, // Agar naik sedikit di atas ikon
                  children: [
                    Container(
                      width: itemWidth / 1.5, // Lebarnya menyesuaikan item navigation
                      height: 5, // Tinggi lebih kecil untuk efek oval
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(defaultPadding), 
                          bottomRight: Radius.circular(defaultPadding)
                        ), // Biar bentuknya oval
                        color: primary500
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: -22, // Naik sedikit di atas oval
                  child: _buildGradientContainer(itemWidth / 1.5)
                )
              ],
            ), 
          ),
        ],
      )
    );
  }
   Widget _buildGradientContainer(double width) {
    return Container(
      width: width, // Lebarnya menyesuaikan item navigation
      height: 25, // Tinggi lebih kecil untuk efek oval
      decoration: BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment(0.00, -1.00),
        end: Alignment(0, 1),
        colors: [Color(0x192759CD), Color(0x00132C67)],
        ),
      ),
    );
  }
}