import 'dart:developer';

import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/camera/camera.dart';
import 'package:Bupin/camera/scann_aniamtion/scanning_effect.dart';
import 'package:Bupin/helper/helper.dart';
import 'package:Bupin/navigation/component/recent_video_item.dart';
import 'package:Bupin/navigation/component/recet_soal_item.dart';
import 'package:Bupin/navigation/navigation_provider.dart';
import 'package:Bupin/navigation/views/tabar.dart';
import 'package:Bupin/styles/PageTransitionTheme.dart';
import 'package:Bupin/video.dart';
import 'package:Bupin/widgets/empty.dart';
import 'package:Bupin/youtube_video/Halaman_Video.dart';
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
              padding: EdgeInsets.only(top: 10),
              margin: EdgeInsets.symmetric(
                horizontal: 15,
              ),
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
                          color: Colors.orangeAccent, shape: BoxShape.circle),
                      child: Image.asset(
                        "asset/9.png",
                        width: 30,
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20, top: 20, left: 15, right: 15),
              height: 150,
              child: Hero(
                  tag: "tag",
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Demo(),
                        ));
                      },
                      child: Container())),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15)),
            ),
            Flexible(child: TabBarDemo())
          ],
        );
      })),
    );
  }
}
