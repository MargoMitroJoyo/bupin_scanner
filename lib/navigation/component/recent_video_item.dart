import 'dart:developer';

import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/helper/capital.dart';
import 'package:Bupin/helper/helper.dart';

import 'package:Bupin/models/Video.dart';
import 'package:Bupin/models/recent_video.dart';
import 'package:Bupin/navigation/navigation_provider.dart';
import 'package:Bupin/youtube_video/Halaman_Video.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

class RecenVideoItem extends StatelessWidget {
  final RecentVideo video;

  RecenVideoItem(
    this.video,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        height: MediaQuery.of(context).size.width * 0.19,
        child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1.5,
                    color: Helper.localColor(video.namaMapel).withOpacity(0.2)),
                borderRadius: BorderRadius.circular(15),
                color: Colors.white),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: StreamBuilder<Object>(
                            stream: null,
                            builder: (context, snapshot) {
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  AspectRatio(
                                      aspectRatio: 16 / 13,
                                      child: FadeInImage.assetNetwork(
                                        placeholder: "asset/loading.png",
                                        placeholderColor: Colors.black,
                                        image: video.imageUrl,
                                        fit: BoxFit.fitHeight,
                                      )),
                                  AspectRatio(
                                      aspectRatio: 16 / 13,
                                      child: Container(
                                        color: Colors.black.withOpacity(0.4),
                                      )),
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      height: 4,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: LinearProgressIndicator(
                                        value: video.recentDuration.inSeconds /
                                            video.totalDuration.inSeconds,
                                        valueColor: AlwaysStoppedAnimation<
                                                Color>(
                                            Helper.localColor(video.namaMapel)),
                                        backgroundColor:
                                            Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.play_arrow_rounded,
                                    color: Colors.white.withOpacity(0.75),
                                    size: 18,
                                  ),
                                ],
                              );
                            }))),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Spacer(),
                        Spacer(),
                        Spacer(),
                        Text(
                          video.namaSubBab.toTitleCase(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: Helper.localColor(video.namaMapel),
                            fontFamily: "Rubik",
                            fontSize: 15,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Kelas ${video.namaKelas.extractNumber()} ${video.namaMapel.toTitleCase()}",
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                        // Text(
                        //   Helper.printDuration(video.recentDuration) +
                        //       " / " +
                        //       Helper.printDuration(video.totalDuration),
                        //   maxLines: 1,
                        //   style: TextStyle(fontSize: 13, color: Colors.grey),
                        //   overflow: TextOverflow.clip,
                        // ),
                        Spacer(),
                        Spacer(),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                      onTap: () {
                        Provider.of<NavigationProvider>(context, listen: false)
                            .selectedRecentVideo = video;
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HalamanVideo(video.link),
                        ));
                      },
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Helper.localColor(video.namaMapel),
                        size: 16,
                      )),
                ),
              ],
            )));
  }
}
