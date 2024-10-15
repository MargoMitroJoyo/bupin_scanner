import 'package:Bupin/navigation/component/recen_ujian_item.dart';
import 'package:Bupin/navigation/component/recent_video_item.dart';
import 'package:Bupin/navigation/component/recet_soal_item.dart';
import 'package:Bupin/navigation/navigation_provider.dart';
import 'package:Bupin/widgets/empty.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabBarDemo extends StatelessWidget {
  const TabBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Consumer<NavigationProvider>(builder: (context, data, c) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: new Size(50.0, 50.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    color: Colors.white),
                child: TabBar(
                  indicatorColor: const Color.fromRGBO(74, 74, 166, 1),
                  unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500,
                      fontFamily: "Nunito"),
                  tabs: [
                    Tab(
                      icon: Text(
                        "Video",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 16),
                      ),
                    ),
                    Tab(
                        icon: Text(
                      "Soal",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                    )),
                    Tab(
                        icon: Text(
                      "PTS/PAS",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                    )),
                  ],
                ),
              ),
            ),
            body: Container(
              color: Colors.white,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  data.recentVideoList.isEmpty
                      ? Empty()
                      : ListView(
                          padding:
                              EdgeInsets.only(top: 10, left: 20, right: 20),
                          children: data.recentVideoList.reversed
                              .map(
                                (e) => RecenVideoItem(e),
                              )
                              .toList()),
                  data.recentSoalList.isEmpty
                      ? Empty()
                      : ListView(
                          padding:
                              EdgeInsets.only(top: 10, left: 20, right: 20),
                          children: data.recentSoalList.reversed
                              .map(
                                (e) => RecenSoalItem(e),
                              )
                              .toList(),
                        ),
                  data.recentUjianList.isEmpty
                      ? Empty()
                      : ListView(
                          padding:
                              EdgeInsets.only(top: 10, left: 20, right: 20),
                          children: data.recentUjianList.reversed
                              .map(
                                (e) => RecenUjianItem(e),
                              )
                              .toList(),
                        ),
                ],
              ),
            ),
          );
        }));
  }
}
