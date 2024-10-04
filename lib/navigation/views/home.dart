import 'dart:developer';

import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/camera/camera.dart';
import 'package:Bupin/navigation/component/recent_video_item.dart';
import 'package:Bupin/navigation/provider/navigation_provider.dart';
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
   Provider.of<NavigationProvider>(context,listen: false).getRecentVideo();
    super.initState();
  }

  double width = 0;
  @override
  Widget build(BuildContext context) {
    log("scan");
    width = MediaQuery.of(context).size.width;

    return Scaffold(floatingActionButton: FloatingActionButton(onPressed: ()async{
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();
    }),
      body:  Consumer<NavigationProvider>(builder: (context, data, c) {
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
                        ...data.recentVideoList
                            .map(
                              (e) => InkWell(
                                  onTap: () {
                                  
                                  },
                                  child: RecenVideoItem(e)),
                            )
                            .toList()
                      ],
                    );
                  })
          
    );
  }
}
