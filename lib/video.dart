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

///
class Demo extends StatefulWidget {
  @override
  DemoState createState() => DemoState();
}

class DemoState extends State<Demo> {
  double aspectRatio = 16 / 9;
  late YoutubePlayerController _controller;
  String linkQrVideo = "";
  Video? video;
  bool noInternet = true;
  String videoThumbnail = "";
  initState() {
    _controller = YoutubePlayerController(
        params: const YoutubePlayerParams(
      strictRelatedVideos: true,
      showFullscreenButton: true,
      color: "red",
    ));

    _controller.loadVideo("https://www.youtube.com/watch?v=kSjGtfcaTjU");
    super.initState();
  }

  @override
  void dispose() {
    _controller.pauseVideo();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("Video");
    // ignore: deprecated_member_use
    return _controller.value.playerState == PlayerState.buffering
        ? CircleAvatar(
            backgroundColor: Colors.white,
          )
        : YoutubePlayerScaffold(
            backgroundColor: Colors.black,
            aspectRatio: 9 / 16,
            controller: _controller,
            builder: (context, player) {
              return Scaffold(body: Center(child: player));
            });
  }
}
