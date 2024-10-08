import 'dart:developer';

import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/camera/camera.dart';
import 'package:Bupin/helper/helper.dart';
import 'package:Bupin/navigation/component/recent_video_item.dart';
import 'package:Bupin/navigation/component/recet_soal_item.dart';
import 'package:Bupin/navigation/navigation_provider.dart';
import 'package:Bupin/styles/PageTransitionTheme.dart';
import 'package:Bupin/widgets/empty.dart';
import 'package:Bupin/youtube_video/Halaman_Video.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

final statusBarHeight = window.viewPadding.top;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    Provider.of<NavigationProvider>(context, listen: false).getRecentVideo();
    Provider.of<NavigationProvider>(context, listen: false).getRecentSoal();
    super.initState();
  }

  double width = 0;
  @override
  Widget build(BuildContext context) {
    log("scan");
    width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
      //   floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     final SharedPreferences prefs = await SharedPreferences.getInstance();
      //     prefs.clear();
      //   },
      // ),
      
      
       body: Consumer<NavigationProvider>(builder: (context, data, c) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.sunny,
                            color: Colors.amber,
                            size: 15,
                          ),
                          Text(
                            " Good Morning",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.amber,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        "Steve Harris",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.red.shade500, shape: BoxShape.circle),
                      child: Image.asset(
                        "asset/9.png",
                        width: 30,
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15)),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "History Video",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Container(padding: EdgeInsets.only(left: 5,right: 5,bottom: 2.5,top: 2.5),decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),border: Border.all(color: Theme.of(context).primaryColor)),
                            child: Text(
                              "Semua",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  color: Theme.of(context).primaryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                    data.recentVideoList.isEmpty
                        ? Empty()
                        : Column(
                            children: data.recentVideoList.reversed
                                .map(
                                  (e) => InkWell(
                                      onTap: () {}, child: RecenVideoItem(e)),
                                )
                                .toList()),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "History Quiz",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                         Container(padding: EdgeInsets.only(left: 5,right: 5,bottom: 2.5,top: 2.5),decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),border: Border.all(color: Theme.of(context).primaryColor)),
                            child: Text(
                              "Semua",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  color: Theme.of(context).primaryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                    data.recentSoalList.isEmpty
                        ? Empty()
                        : Column(
                            children: data.recentSoalList.reversed
                                .map(
                                  (e) => InkWell(
                                      onTap: () {}, child: RecenSoalItem(e)),
                                )
                                .toList(),
                          )
                  ],
                ),
              ),
            ),
          ],
        );
      })),
    );
  }
}
