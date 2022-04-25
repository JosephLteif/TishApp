import 'package:TishApp/TishApp/screen/FavoritesPage.dart';
import 'package:TishApp/TishApp/screen/SetLocationPage.dart';
import 'package:TishApp/TishApp/screen/TishAppDashboard.dart';
import 'package:TishApp/TishApp/screen/TishAppProfilePage.dart';
import 'package:TishApp/TishApp/utils/TishAppColors.dart';
import 'package:flutter/material.dart';

class TishAppMainPage extends StatefulWidget {
  @override
  TishAppMainPageState createState() => TishAppMainPageState();
}

class TishAppMainPageState extends State<TishAppMainPage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    TishAppDashboard(),
    FavoritesPage(),
    SetLocationPage(),
    ProfilePage()
  ];

  @override
  void initState() {
    super.initState();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 0,
          unselectedFontSize: 0,
          elevation: 5,
          selectedItemColor: mainColorTheme,
          unselectedItemColor: Colors.grey,
          currentIndex:
              _currentIndex, // this will be set when a new tab is tapped
          onTap: onTabTapped, // new
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.pin_drop), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          ]),
      body: _children[_currentIndex],
    );
  }
}
