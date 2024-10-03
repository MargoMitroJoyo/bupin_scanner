import 'package:Bupin/Banner.dart';
import 'package:Bupin/Halaman_Soal.dart';
import 'package:Bupin/Home_Bank_Soal.dart';
import 'package:Bupin/Home_Het.dart';
import 'package:Bupin/Home_LeaderBoard.dart';
import 'package:Bupin/Home_PTS&PAS.dart';
import 'package:Bupin/Home_Scan.dart';
import 'package:Bupin/styles/PageTransitionTheme.dart';
import 'package:flutter/material.dart';

/// Flutter code sample for [BottomNavigationBar].

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
    _controller.animateTo(1);
  }

  int _selectedIndex = 3;

  static const List<Widget> _widgetOptions = <Widget>[
    HalmanHet(),
    HalmanScan(),
    HalamanBelajar(),
    HomeLeaderboard(),
  ];

  void _onItemTapped(int index) {
    _selectedIndex = index;
    setState(() {
      _controller.animateTo(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Scaffold(
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _controller,
            children: _widgetOptions,
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_rounded),
                label: 'E-Book BSE',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books_rounded),
                label: 'Bank Soal',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.leaderboard),
                label: 'Leaderboard',
              ),
            ],
            currentIndex: _selectedIndex,
            unselectedItemColor: Theme.of(context).primaryColor,
            selectedItemColor: Theme.of(context).primaryColor,
            onTap: _onItemTapped,
          ),
        ),
        const HalamanBanner()
      ],
    );
  }
}
