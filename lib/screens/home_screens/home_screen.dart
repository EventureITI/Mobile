import 'package:eventure/screens/home_screens/explore_tab.dart';
import 'package:eventure/screens/home_screens/home_tab.dart';
import 'package:eventure/screens/profile_screens/profile_tab.dart';
import 'package:eventure/utils/text_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static List<Widget> _tabs = <Widget>[
    HomeTab(),
    ExploreTab(),
    ProfileTab()
    // Text("Home Page", style: TextStyle(color: Colors.white, fontSize: 30),),
    // Text("Explore", style: TextStyle(color: Colors.white, fontSize: 30),),
    // Text("Profile Page", style: TextStyle(color: Colors.white, fontSize: 30),),
  ];

  void _itemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: bgColor,
          child: Center(child: _tabs.elementAt(_selectedIndex))),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "Explore", icon: Icon(Icons.search)),
          BottomNavigationBarItem(label: "Profile", icon: Icon(Icons.person)),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: selectedNav,
        unselectedItemColor: iconColor,
        backgroundColor: navBgItem,
        onTap: _itemTapped,
      ),
    );
  }
}
