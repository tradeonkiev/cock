// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:untitled/clicker_page.dart';
import 'package:untitled/shop_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    ClickerPage(),
    ShopPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(30, 52, 62, 1.0),
        title: const Text(
            'сookie game',
            style:
            TextStyle(
              color: Colors.white,
            )
        ),
      ),
      body: _pages[_currentIndex],

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color.fromRGBO(26, 44, 51, 1.0),
        color: const Color.fromRGBO(30, 52, 62, 1.0),
        animationDuration: const Duration(milliseconds: 300),
        index: _currentIndex,
        items: const [
          Icon(
            Icons.cookie,
            size: 30,
            color: Colors.blue,
          ),
          Icon(
              Icons.shopping_cart,
              size: 30,
              color: Colors.blue,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

