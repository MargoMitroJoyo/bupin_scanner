import 'dart:convert';

import 'package:Bupin/models/recent_soal.dart';
import 'package:Bupin/models/recent_video.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationProvider extends ChangeNotifier {
  List<RecentSoal> recentSoalList = [];
  RecentSoal? selectedRecentSoal;
  List<RecentVideo> recentVideoList = [];
  RecentVideo? selectedRecentVideo;
  late PodPlayerController controller;

  set setConttoler(val) {
    controller = val;
  }

  pause() {
    controller.pause();
    notifyListeners();
  }

  play() {
    controller.play();
    notifyListeners();
  }

  set selectingRecentSoal(val) {
    selectedRecentSoal = val;
    notifyListeners();
  }

  addRecentSoal(RecentSoal data) {
    if (!recentSoalList
        .map(
          (e) => e.namaBab,
        )
        .toList()
        .contains(data.namaBab)) {
      recentSoalList.add(data);
    }

    saveRecentSoal();
    notifyListeners();
  }

  updateRecentSoal(RecentSoal data) {
    recentSoalList[recentSoalList.indexOf(selectedRecentSoal!)] = data;
    saveRecentSoal();
    notifyListeners();
  }

  getRecentSoal() async {
    recentSoalList.clear();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getStringList(
          "recentSoal",
        ) ??
        [];

    for (var element in data) {
      recentSoalList.add(RecentSoal.fromMap(jsonDecode(element)));
    }
    notifyListeners();
  }

  saveRecentSoal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        "recentSoal",
        recentSoalList
            .map(
              (e) => jsonEncode(RecentSoal.toJson(e)),
            )
            .toList());
  }

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
    recentVideoList.clear();
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