import 'package:Bupin/banner/Banner.dart';
import 'package:Bupin/camera/camera.dart';
import 'package:Bupin/navigation/views/het.dart';
import 'package:Bupin/navigation/views/leaderboard.dart';
import 'package:Bupin/navigation/views/bank_soal.dart';
import 'package:Bupin/navigation/views/home.dart';
import 'package:Bupin/styles/PageTransitionTheme.dart';
import 'package:flutter/material.dart';

/// Flutter code sample for [BottomNavigationBar].

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
    _controller.animateTo(1);
  }

  int _selectedIndex = 3;

  static const List<Widget> _widgetOptions = <Widget>[
    BSE(),
    Home(),
    BankSoal(),
    Leaderboard(),
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: Stack(alignment: Alignment.center, children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QRViewExample(false),
                ));
              },
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.width * 0.15,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(100),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 20,
                        offset: const Offset(0.5, 0.5),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.qr_code_scanner_rounded,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.width * 0.09,
                  )),
            )
          ]),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _controller,
            children: _widgetOptions,
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,type: BottomNavigationBarType.fixed,
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
            currentIndex: _selectedIndex,unselectedItemColor: Colors.grey,
            selectedItemColor: Theme.of(context).primaryColor,
            onTap: _onItemTapped,
          ),
        ),
        const HalamanBanner()
      ],
    );
  }
}
