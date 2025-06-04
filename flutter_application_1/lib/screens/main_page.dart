// main_page.dart
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'part_shop_screen.dart';
import 'search_screen.dart';
import 'my_menu_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  // 네 개 화면을 리스트로 관리
  final List<Widget> _screens = const [
    HomeScreen(),
    PartShopScreen(),
    SearchScreen(),
    MyMenuScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // 4개 이상 탭이면 fixed 사용 추천
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.memory), label: 'PART SHOP'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'SEARCH'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'MY'),
        ],
      ),
    );
  }
}
