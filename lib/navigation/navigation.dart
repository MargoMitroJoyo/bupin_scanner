import 'package:Bupin/WebivewPolos.dart';
import 'package:Bupin/banner/Banner.dart';
import 'package:Bupin/camera/camera.dart';
import 'package:Bupin/navigation/views/het.dart';
import 'package:Bupin/navigation/views/leaderboard.dart';
import 'package:Bupin/navigation/views/bank_soal.dart';
import 'package:Bupin/navigation/views/home.dart';
import 'package:Bupin/styles/PageTransitionTheme.dart';
import 'package:Bupin/webivew_soal.dart';
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
    _controller = TabController(length: 3, vsync: this);
    _controller.animateTo(1);
  }

  int _selectedIndex = 1;

  static const List<Widget> _widgetOptions = <Widget>[
    BSE(),
    Home(),
    BankSoal(),
    // Leaderboard(),
  ];

void _onItemTapped(int index) {
    if (index != 2) {
      _selectedIndex = index;
      setState(() {
        _controller.animateTo(index);
      });
    } else {
      _selectedIndex = index;

      showModalBottomSheet(
          context: context,
          builder: (builder) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(CustomRoute(
                      builder: (context) => const  WebviewSoal(
                          "https://tim.bupin.id/cbtakm/login.php?6666",
                          "Bank Soal SD/MI",
                          false,
                          ""),
                    ));
                  },
                  child: Container(
                      color: const Color.fromRGBO(205, 32, 49, 0.1),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                              "asset/Halaman_Latihan_PAS&PTS/Icon SD@4x.png",
                              width: 50),
                        ),
                        const Spacer(),
                        const Text(
                          "SD/MI",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(205, 32, 49, 1),
                              fontSize: 18),
                        ),
                        const Spacer(),
                  Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                              "asset/Halaman_Latihan_PAS&PTS/Icon SMA@4x.png",
                              color: Colors.transparent,
                              width: 50),
                        ),
                      ])),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(CustomRoute(
                      builder: (context) => const  WebviewSoal(
                          "https://tim.bupin.id/cbtakm/login.php?7777",
                          'Bank Soal SMP/MTS',
                          false,
                          ""),
                    ));
                  },
                  child: Container(
                      color: const Color.fromRGBO(58, 88, 167, 0.1),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                              "asset/Halaman_Latihan_PAS&PTS/Icon SMP@4x.png",
                              width: 50),
                        ),
                        const Spacer(),
                        const Text(
                          "SMP/MTS",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(58, 88, 167, 1),
                              fontSize: 18),
                        ),
                        const Spacer(),
                    Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                              "asset/Halaman_Latihan_PAS&PTS/Icon SMA@4x.png",
                              color: Colors.transparent,
                              width: 50),
                        ),
                      ])),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(CustomRoute(
                      builder: (context) => const WebviewSoal(
                          "https://tim.bupin.id/cbtakm/login.php?9999",
                          'Bank Soal SMA/MA',
                          false,
                          ""),
                    ));
                  },
                  child: Container(
                      color: const Color.fromRGBO(120, 163, 215, 0.1),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                              "asset/Halaman_Latihan_PAS&PTS/Icon SMA@4x.png",
                              width: 50),
                        ),
                        const Spacer(),
                        const Text(
                          "SMA/MA",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(120, 163, 215, 1),
                              fontSize: 18),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                              "asset/Halaman_Latihan_PAS&PTS/Icon SMA@4x.png",
                              color: Colors.transparent,
                              width: 50),
                        ),
                      ])),
                ),
              ],
            );
          });
    }
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
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.leaderboard),
              //   label: 'Leaderboard',
              // ),
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
