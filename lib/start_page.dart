import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:edulex_school/pages/Attendance.dart';
import 'package:edulex_school/pages/Banking.dart';
import 'package:edulex_school/pages/Home.dart';
import 'package:edulex_school/pages/Settings.dart';
import 'package:flutter/material.dart';

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
          'EDU-LEX School',
          style: TextStyle(fontWeight: FontWeight.bold),
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
        items:
      [Icon(
        _currentIndex == 0 ? Icons.home :Icons.home_outlined,
        size: 30,
        color: Colors.white,
      ),
      Icon(
        _currentIndex == 1 ? Icons.search : Icons.search_outlined,
        size: 30,
        color: Colors.white,
      ),
      Icon(
        _currentIndex == 2 ? Icons.people : Icons.people_outlined,
        size: 30,
        color: Colors.white,
      ),
      Icon(
        _currentIndex == 3 ? Icons.settings : Icons.settings_outlined,
        size: 30,
        color: Colors.white,
      )]
        ,),
    );
  }
}