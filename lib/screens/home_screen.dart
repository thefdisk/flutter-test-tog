import 'package:flutter/material.dart';

import 'screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final screens = [
    const HomeContent(),
    const CartScreen(),
  ];

  void _changeIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.greenAccent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (value) => _changeIndex(value),
        items: const [
          BottomNavigationBarItem(
            label: 'Beranda',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Keranjang',
            icon: Icon(
              Icons.shopping_cart,
            ),
          ),
        ],
      ),
    );
  }
}
