import 'dart:developer';

import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/helper.dart';

import 'package:Bupin/models/Video.dart';
import 'package:Bupin/models/recent_video.dart';
import 'package:Bupin/navigation/navigation_provider.dart';
import 'package:Bupin/youtube_video/Halaman_Video.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class RecenVideoItem extends StatefulWidget {
  final RecentVideo video;

  RecenVideoItem(
    this.video,
  );

  @override
  State<RecenVideoItem> createState() => _RecenVideoItemState();
}

class _RecenVideoItemState extends State<RecenVideoItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<NavigationProvider>(context,listen: false).selectedRecentVideo=widget.video;
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HalamanVideo(widget.video.link),
        ));
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(3.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        FadeInImage.assetNetwork(
                          placeholder: "asset/loading.png",
                          placeholderColor: Theme.of(context).primaryColor,
                          image: widget.video.imageUrl,
                        ),  FadeInImage.assetNetwork(
                          placeholder: "asset/loading.png",
                          placeholderColor: Theme.of(context).primaryColor,
                          image: widget.video.imageUrl,color: Colors.black.withOpacity(0.4),
                        ),
                        Container(
                          color: Colors.red.withOpacity(0.5),
                        )
                      ],
                    )),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.video.namaSubBab,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                    Row(
                      children: [
                        Text(Helper.printDuration(widget.video.recentDuration)),
                        Text("/" +
                            Helper.printDuration(widget.video.totalDuration)),
                      ],
                    )
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
