import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/customer-services/dashboard-cs/cs_screen.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation_home_screen.dart';
import 'package:trusin_app/ui/supervisor/rank-supervisor/rank_screen.dart';

class BottomNavbarCS extends StatefulWidget {
  const BottomNavbarCS({super.key});

  @override
  State<BottomNavbarCS> createState() => _BottomNavbarCSState();
}

class _BottomNavbarCSState extends State<BottomNavbarCS> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navigasi ke halaman sesuai index
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: 
        (context) => DashboardCsScreen()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: 
        (context) => QuotationCSHomeScreen()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: 
        (context) => CSRankScreen()));
        break;
    }
  } 
  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth / 3; // Karena ada 4 item
    return Scaffold(
      body: IndexedStack(
      index: _selectedIndex,
      children: [
        DashboardCsScreen(),
        QuotationCSHomeScreen(),
        CSRankScreen(),
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
                  'assets/icons/quotation.svg',
                  colorFilter: ColorFilter.mode( _selectedIndex == 1 ? primary500 : Colors.grey, BlendMode.srcIn),
                ),
                label: 'Quotation'
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/rank.svg',
                  colorFilter: ColorFilter.mode( _selectedIndex == 1 ? primary500 : Colors.grey, BlendMode.srcIn),
                ),
                label: 'Rank'
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