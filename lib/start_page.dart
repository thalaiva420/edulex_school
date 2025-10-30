import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:edulex_school/pages/Attendance.dart';
import 'package:edulex_school/pages/Banking.dart';
import 'package:edulex_school/pages/Home.dart';
import 'package:edulex_school/pages/Settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage>{
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    Attendance(),
    Banking(),
    Settings()
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4B352A),
        foregroundColor: Colors.white,
        title: Text(
          _currentIndex == 0
              ? 'EDU-LEX School'
              : _currentIndex == 1
              ? 'Attendance'
              : _currentIndex == 2
              ? 'Banking'
              : 'Settings',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: Color(0xFF4B352A),
        buttonBackgroundColor: Color(0xFFCA7842),
        animationCurve: Curves.fastEaseInToSlowEaseOut,
        animationDuration: const Duration(milliseconds: 650) ,
        backgroundColor: Colors.transparent,
        onTap: (value){
          setState(() {
            _currentIndex = value;
          });
        },
          items: <Widget>[
            SvgPicture.asset(
              _currentIndex == 0
                  ? 'assets/icons/ic_home_filled.svg'
                  : 'assets/icons/ic_home_outlined.svg',
              color: Colors.white,
              width: 30,
              height: 30,
            ),
            SvgPicture.asset(
              _currentIndex == 1
                  ? 'assets/icons/ic_attendance_filled.svg'
                  : 'assets/icons/ic_attendance_outlined.svg',
              color: Colors.white,
              width: 35,
              height: 30,
            ),
            SvgPicture.asset(
              _currentIndex == 2
                  ? 'assets/icons/ic_banking_filled.svg'
                  : 'assets/icons/ic_banking_outlined.svg',
              color: Colors.white,
              height: 30,
              width: 30,
            ),
            SvgPicture.asset(
              _currentIndex == 3
                  ? 'assets/icons/ic_settings_filled.svg'
                  : 'assets/icons/ic_settings_outlined.svg',
              color: Colors.white,
              height: 30,
              width: 30,
            ),

          ]
      //   items:
      //
      // [Icon(
      //   _currentIndex == 0 ? Icons.home :Icons.home_outlined,
      //   size: 30,
      //   color: Colors.white,
      // ),
      // Icon(
      //   _currentIndex == 1 ? Icons.search : Icons.search_outlined,
      //   size: 30,
      //   color: Colors.white,
      // ),
      // Icon(
      //   _currentIndex == 2 ? Icons.people : Icons.people_outlined,
      //   size: 30,
      //   color: Colors.white,
      // ),
      // Icon(
      //   _currentIndex == 3 ? Icons.settings : Icons.settings_outlined,
      //   size: 30,
      //   color: Colors.white,
    //       ImageIcon(
    //       AssetImage('assets/icons/ic_home_outlined.png'),
    //   color: Colors.white,
    //   size: 30,
    // ),
      // )]
        ,),
    );
  }
}