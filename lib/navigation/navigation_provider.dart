import 'dart:convert';

import 'package:Bupin/models/recent_soal.dart';
import 'package:Bupin/models/recent_video.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationProvider extends ChangeNotifier {
  List<RecentVideo> recentVideoList = [];
  List<RecentSoal> recentSoalList = [];
  RecentVideo? selectedRecentVideo;

  set selectingRecentVideo(val) {
    selectedRecentVideo = val;
    notifyListeners();
  }

  addRecentVideo(RecentVideo data) {
    if (!recentVideoList
        .map(
          (e) => e.imageUrl,
        )
        .toList()
        .contains(data.imageUrl)) {
      recentVideoList.add(data);
    }

    saveRecentVideo();
    notifyListeners();
  }

  updateRecentVideo(RecentVideo data) {
    recentVideoList[recentVideoList.indexOf(selectedRecentVideo!)] = data;
    saveRecentVideo();
    notifyListeners();
  }

  getRecentVideo() async {
    recentSoalList.clear();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getStringList(
          "recentVideo",
        ) ??
        [];

    for (var element in data!) {
      recentVideoList.add(RecentVideo.fromMap(jsonDecode(element)));
    }
    notifyListeners();
  }

  saveRecentVideo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        "recentVideo",
        recentVideoList
            .map(
              (e) => jsonEncode(RecentVideo.toJson(e)),
            )
            .toList());
  }
}

 
  // saveRecentSoal() {}
  // getRecentSoal() {}