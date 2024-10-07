import 'dart:developer';

import 'package:Bupin/ApiServices.dart';
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
    return InkWell(
      onTap: () {
        Provider.of<NavigationProvider>(context, listen: false)
            .selectedRecentVideo = video;
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HalamanVideo(video.link),
        ));
      },
      child: Container(margin: EdgeInsets.symmetric(vertical: 5),
        height: MediaQuery.of(context).size.width * 0.18,
        child: Container(
          // padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
                  width: 2,
                  color: Theme.of(context).primaryColor.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(15),
              color: Colors.white),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        FadeInImage.assetNetwork(
                          placeholder: "asset/loading.png",
                          placeholderColor: Theme.of(context).primaryColor,
                          image: video.imageUrl,
                        ),
                        FadeInImage.assetNetwork(
                          placeholder: "asset/loading.png",
                          placeholderColor: Theme.of(context).primaryColor,
                          image: video.imageUrl,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        Container(
                          color: Colors.red.withOpacity(0.5),
                        )
                      ],
                    )),
              ),
              Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child:Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child:  Padding(
                      padding: const EdgeInsets.only(bottom:  10),
                      child: Text(
                        video.namaSubBab,
                        maxLines: 2,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: LinearProgressIndicator(
                        value: video.recentDuration.inSeconds /
                            video.totalDuration.inSeconds,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor),
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(0.2),
                      ),
                    ),
                  )
                ],
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Theme.of(context).primaryColor,
                  size: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
