import 'dart:developer';

import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/camera/camera.dart';
import 'package:Bupin/helper/helper.dart';
import 'package:Bupin/navigation/component/recent_video_item.dart';
import 'package:Bupin/navigation/navigation_provider.dart';
import 'package:Bupin/styles/PageTransitionTheme.dart';
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
          floatingActionButton: FloatingActionButton(onPressed: ()async{
        //      final SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.clear();
        },
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(CustomRoute(
                  builder: (context) => const QRViewExample(false),
                ));
              },
              child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Icon(
                    Icons.qr_code_scanner_rounded,
                    color: Colors.white,
                    size: width * 0.2,
                  )),
            ),
          ),
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
              margin: EdgeInsets.only(
              bottom: 10,left: 15,right: 15
              ),
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15)),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "History Video",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            "See All",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                    ),
                    ...data.recentVideoList.reversed
                        .map(
                          (e) => InkWell(onTap: () {}, child: RecenVideoItem(e)),
                        )
                        .toList(),
                         Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "History Soal",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            "See All",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                    ),
                    ...data.recentSoalList.reversed
                        .map((e) => InkWell(
                              onTap: () {
                                Provider.of<NavigationProvider>(context,
                                        listen: false)
                                    .selectedRecentSoal = e;
                              },
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.17,
                                  child: Container(
                                      // padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.2),
                                              spreadRadius: 0.5,
                                              blurRadius: 5,
                                              offset: Offset(0,
                                                  0), // changes position of shadow
                                            ),
                                          ],
                                          borderRadius: BorderRadius.circular(8),
                                          color: Colors.white),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            Helper.localAsset(e.imageAsset),
                                            width: 50,
                                          ),
                                          Column(
                                            children: [
                                              Text(e.namaBab.toString()),
                                              Text(e.imageAsset.toString()),
                                              Text(e.namaMapel.toString()),
                                            ],
                                          ),
                                        ],
                                      ))),
                            ))
                        .toList()
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