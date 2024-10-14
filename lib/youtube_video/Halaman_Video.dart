// Copyright 2020 Sarbagya Dhaubanjar. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:developer';

import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/camera/camera_provider.dart';
import 'package:Bupin/models/recent_video.dart';
import 'package:Bupin/navigation/navigation_provider.dart';
import 'package:Bupin/youtube_video/Halaman_Laporan_Error.dart';
import 'package:Bupin/models/video.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:provider/provider.dart';
import 'component/play_pause_button_bar.dart';

///
class HalamanVideo extends StatefulWidget {
  final String link;

  const HalamanVideo(this.link, {super.key});
  @override
  HalamanVideoState createState() => HalamanVideoState();
}

class HalamanVideoState extends State<HalamanVideo>
    with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..animateTo(1);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeIn,
  );

  double aspectRatio = 16 / 9;
  late YoutubePlayerController _controller;
  String linkQrVideo = "";
  Video? video;
  bool noInternet = true;
  String videoThumbnail = "";
  updatingRecent() async {
    var recent = await _controller.currentTime;
    var total = _controller.value.metaData.duration;
    if (Provider.of<NavigationProvider>(context, listen: false)
            .selectedRecentVideo ==
        null) {
      log("addRcentVideo");

      Provider.of<NavigationProvider>(context, listen: false)
          .addRecentVideo(RecentVideo(
              widget.link,
              videoThumbnail,
              video!.namaVideo!,
              Duration(
                seconds: recent.toInt(),
              ),
              Duration(
                seconds: total.inSeconds,
              )));
    } else {
      log("update recent");
      Provider.of<NavigationProvider>(context, listen: false)
          .updateRecentVideo(RecentVideo(
              widget.link,
              videoThumbnail,
              video!.namaVideo!,
              Duration(
                seconds: recent.toInt(),
              ),
              Duration(
                seconds: total.inSeconds,
              )));
    }
    Provider.of<NavigationProvider>(context, listen: false)
        .selectingRecentVideo = null;
  }

  @override
  void dispose() async {
    _animationController.dispose();

    super.dispose();
  }

  Future<void> fetchApi() async {
    final dio = Dio();

    linkQrVideo = widget.link
        .replaceAll("buku.bupin.id/?", "buku.bupin.id/api/vid.php?");
    final response = await dio.get(linkQrVideo);
log(response.data.toString());
    log(response.statusCode.toString());
    if (response.statusCode != 200) {
      noInternet = true;
      return;
    }
    noInternet = false;
    if (response.data["ytid"] == null &&
        response.data["ytidDmp"] == null) {
      return;
    } else {
      video = Video.fromMap(response.data);
    }
    if (video != null) {
      _controller = YoutubePlayerController(
          params: const YoutubePlayerParams(
        strictRelatedVideos: true,
        showFullscreenButton: true,
        color: "red",
      ));
      _controller.setFullScreenListener(
        (isFullScreen) {},
      );
      if (Provider.of<NavigationProvider>(context, listen: false)
              .selectedRecentVideo !=
          null) {
        var seconds = Provider.of<NavigationProvider>(context, listen: false)
            .selectedRecentVideo!
            .recentDuration
            .inSeconds
            .toString();
        log("seek to");
        _controller.loadVideo("${video!.linkVideo!}&t=$seconds");
      } else {
        _controller.loadVideo(video!.linkVideo!);
      }
      final data = await ApiService.isVertical(video!);
      videoThumbnail = data!["imageUrl"];
      log(videoThumbnail);
      if (data["isVertical"]) {
        aspectRatio = 9 / 16;
      } else {
        aspectRatio = 16 / 9;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    log("Video");
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if (_controller.value.fullScreenOption.enabled) {
          _controller.exitFullScreen();
          return Future.value(false);
        }
        Provider.of<CameraProvider>(context, listen: false).scaning = false;

        updatingRecent();

        return Future.value(true);
      },
      child: FutureBuilder<void>(
          future: fetchApi(),
          builder: (context, snapshot) {
            return (noInternet == true)
                ? Scaffold(
                    appBar: AppBar(
                      centerTitle: true,
                      automaticallyImplyLeading: false,
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    backgroundColor: Colors.white,
                    body: Center(
                        child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                      backgroundColor: const Color.fromRGBO(236, 180, 84, 1),
                    )),
                  )
                : video == null
                    ? HalamanLaporan(
                        linkQrVideo.replaceAll(
                          "https://bupin.id/api/apibarang.php?kodeQR=",
                          "",
                        ),
                      )
                    : YoutubePlayerScaffold(
                        backgroundColor: Colors.black,
                        aspectRatio: aspectRatio,
                        controller: _controller,
                        builder: (context, player) {
                          return Scaffold(
                              backgroundColor: Colors.white,
                              appBar: AppBar(
                                centerTitle: true,
                                leading: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: GestureDetector(
                                      onTap: () {
                                        Provider.of<CameraProvider>(context,
                                                listen: false)
                                            .scaning = false;

                                        _controller.stopVideo();
                                        updatingRecent();
                                        Navigator.pop(context, false);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Center(
                                          child: Icon(
                                            Icons.arrow_back_rounded,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 15,
                                            weight: 100,
                                          ),
                                        ),
                                      )),
                                ),
                                backgroundColor: Theme.of(context).primaryColor,
                                title: Text(
                                  video!.namaVideo!,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              body: LayoutBuilder(
                                builder: (context, constraints) {
                                  return Column(
                                    children: [
                                      Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Image.asset(
                                              "asset/logo.png",
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                            ),
                                            FadeTransition(
                                                opacity: _animation,
                                                child: player)
                                          ]),
                                      aspectRatio == 9 / 16
                                          ? const SizedBox()
                                          : Expanded(
                                              child: Stack(
                                                alignment: Alignment.topCenter,
                                                children: [
                                                  Container(
                                                    color: Colors.white,
                                                  ),
                                                  aspectRatio == 9 / 16
                                                      ? const SizedBox()
                                                      : Positioned.fill(
                                                          child: Opacity(
                                                            opacity: 0.8,
                                                            child: Image.asset(
                                                              "asset/Halaman_HET/Doodle HET-8.png",
                                                              repeat:
                                                                  ImageRepeat
                                                                      .repeatY,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              fit: BoxFit
                                                                  .fitWidth,
                                                            ),
                                                          ),
                                                        ),
                                                  aspectRatio == 9 / 16
                                                      ? const SizedBox()
                                                      : Positioned.fill(
                                                          top: 0,
                                                          child: Opacity(
                                                            opacity: 0.05,
                                                            child: Image.asset(
                                                              "asset/Halaman_Scan/Cahaya Halaman Scan@4x.png",
                                                              repeat:
                                                                  ImageRepeat
                                                                      .repeatY,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              fit: BoxFit
                                                                  .fitWidth,
                                                            ),
                                                          ),
                                                        ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 0.0),
                                                    child: PlayPauseButtonBar(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ],
                                  );
                                },
                              ));
                        },
                      );
          }),
    );
  }
}

class Controls extends StatelessWidget {
  const Controls({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlayPauseButtonBar(),
        ],
      ),
    );
  }
}

///

