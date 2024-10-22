import 'dart:developer';

import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/bank_soal/custom_button.dart';
import 'package:Bupin/models/recent_soal.dart';
import 'package:Bupin/models/recent_video.dart';
import 'package:Bupin/navigation/component/recen_ujian_item.dart';
import 'package:Bupin/navigation/views/home/bank_soal.dart';
import 'package:Bupin/navigation/views/home/custtom.dart';
import 'package:Bupin/bank_soal/mapel_provider.dart';
import 'package:Bupin/camera/camera.dart';
import 'package:Bupin/camera/scann_aniamtion/scanning_effect.dart';
import 'package:Bupin/helper/helper.dart';
import 'package:Bupin/navigation/component/recent_video_item.dart';
import 'package:Bupin/navigation/component/recet_soal_item.dart';
import 'package:Bupin/navigation/navigation_provider.dart';
import 'package:Bupin/navigation/views/home/header_card.dart';
import 'package:Bupin/navigation/views/tabar.dart';
import 'package:Bupin/styles/PageTransitionTheme.dart';
import 'package:Bupin/video.dart';
import 'package:Bupin/widgets/empty.dart';
import 'package:Bupin/youtube_video/Halaman_Video.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:pod_player/pod_player.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

import 'package:youtube_player_iframe/youtube_player_iframe.dart';

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
    Provider.of<NavigationProvider>(context, listen: false).getRecentUjian();
    Provider.of<MapelProvider>(context, listen: false)
        .getRecentMapel("SMA XII");
    super.initState();
  }

  double width = 0;
  @override
  Widget build(BuildContext context) {
    log("scan");
    width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromRGBO(243, 247, 250, 1),
          //   floatingActionButton: FloatingActionButton(
          //   onPressed: () async {
          //     final SharedPreferences prefs = await SharedPreferences.getInstance();
          //     prefs.clear();
          //   },
          // ),

          body: Consumer<NavigationProvider>(builder: (context, data, c) {
            log("build home");
            return ListView(
              children: [
                Container(
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.only(top: 10, left: 15, right: 15),
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
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              shape: BoxShape.circle),
                          child: Image.asset(
                            "asset/9.png",
                            width: 30,
                          )),
                    ],
                  ),
                ),

                HeaderCard(),
                Container(
                  child: FlutterCarousel(
                    options: FlutterCarouselOptions(
                      disableCenter: true,
                      floatingIndicator: false,
                      indicatorMargin: 0,
                      aspectRatio: 6 / 2.3,
                      viewportFraction: 0.93,
                      pageSnapping: true,
                      enableInfiniteScroll: true,
                      slideIndicator: CircularSlideIndicator(
                          slideIndicatorOptions: SlideIndicatorOptions(
                              alignment: Alignment.bottomCenter,
                              padding: EdgeInsets.all(0),
                              indicatorRadius: 4.5,
                              indicatorBackgroundColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.3),
                              currentIndicatorColor:
                                  Theme.of(context).primaryColor)),
                    ),
                    items: List.generate(
                        3,
                        (index) => Padding(
                            padding: const EdgeInsets.only(
                                left: 3, right: 3, bottom: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade400,
                                  borderRadius: BorderRadius.circular(10)),
                            ))),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Divider(
                    thickness: 2,
                    height: 0,
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(left: 15,right: 15,bottom: 20),
                //   height: 100,
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(15),
                //       gradient: LinearGradient(
                //         begin: Alignment.topRight,
                //         end: Alignment.bottomLeft,
                //         colors: [
                //           Theme.of(context).primaryColor.withOpacity(0.6),
                //           Theme.of(context).primaryColor,
                //         ],
                //       )),
                // ), // Flexible(child: TabBarDemo())

                BankSoal(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Divider(
                    thickness: 2,
                    height: 0,
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      right: 15, left: 15, top: 15, bottom: 7.5),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Aktivitas Terakhir",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => TabBarDemo(),
                                ));
                              },
                              child: Text(
                                "Lihat Semua",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 3,
                                  decorationColor:
                                      Theme.of(context).primaryColor,
                                ),
                              ),
                            )
                          ]),
                    ],
                  ),
                ),

                Container(
                  height: MediaQuery.of(context).size.width * 0.22,
                  padding: EdgeInsets.only(left: 9),
                  child:
                      Consumer<NavigationProvider>(builder: (context, data, c) {
                    return ListView(
                        scrollDirection: Axis.horizontal,
                        children: data.allRecentList.map((e) {
                          log(e.runtimeType.toString());
                          if (e.runtimeType == RecentSoal) {
                            return RecenSoalItem(e);
                          } else if (e.runtimeType == RecentVideo) {
                            return RecenVideoItem(e);
                          } else {
                            return RecenUjianItem(e);
                          }
                        }).toList());
                  }),
                ),
                SizedBox(
                  height: 300,
                )
              ],
            );
          })),
    );
  }
}
