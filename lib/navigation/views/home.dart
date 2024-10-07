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

    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
    }), body: Consumer<NavigationProvider>(builder: (context, data, c) {
      return Column(
        children: [
          InkWell(
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
          ...data.recentVideoList.reversed
              .map(
                (e) => InkWell(onTap: () {}, child: RecenVideoItem(e)),
              )
              .toList(),
          ...data.recentSoalList.reversed
              .map(
                (e) => InkWell(
                    onTap: () {
                      Provider.of<NavigationProvider>(context, listen: false)
                          .selectedRecentSoal = e;
                    },
                    child: Container(
        height: MediaQuery.of(context).size.width * 0.17,
        child: Container(
          // padding: EdgeInsets.all(10),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 0.5,
              blurRadius: 5,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ], borderRadius: BorderRadius.circular(8), color: Colors.white),
          child: Row(
                      children: [
                        Image.asset(Helper.localAsset(e.imageAsset),width: 50,),
                        Column(
                          children: [
                            Text(e.namaBab.toString()),
                              Text(e.namaMapel.toString()),
                          ],
                        ),
                      ],
                    ))),
              ))
              .toList()
        ],
      );
    }));
  }
}
