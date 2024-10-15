import 'dart:convert';
import 'dart:developer';

import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/helper/helper.dart';
import 'package:Bupin/models/mapel.dart';
import 'package:Bupin/models/recent_soal.dart';
import 'package:Bupin/models/recent_video.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapelProvider extends ChangeNotifier {
  List<String> listMapel = [];
  List<Mapel> listSelctedMapel = [];
    List<Mapel> listSelctedMapelPas = [];
  int selectedKelas = 1;
  String selectedMapel = "Matematika";
  String selectedJenjang = "SD";

set selectingMapel(v){
selectedMapel=v;
  notifyListeners();
}

  getRecentMapel(String jenjang) async {
    listMapel.clear();
    selectedJenjang = jenjang.contains("SD")
        ? "SD"
        : jenjang.contains("SMP")
            ? "SMP"
            : "SMA";
    selectedKelas = list.indexOf(jenjang) + 1;
    var data = await ApiService.getMapelList(
        jenjang.contains("SD")
            ? "SD"
            : jenjang.contains("SMP")
                ? "SMP"
                : "SMA",
        list.indexOf(jenjang) + 1);
    List<String> agama = [];

    for (var element in data) {
      if (Helper.localColor(
              Helper.addSpaceAfterCapitalized(element.toString())) ==
          const Color.fromARGB(255, 63, 63, 63)) {
        agama.add(Helper.addSpaceAfterCapitalized(element));
      } else {
        listMapel.add(Helper.addSpaceAfterCapitalized(element.toString()));
      }
    }
    listMapel.addAll(agama);
    notifyListeners();
  }

  getListMapelPTS( ) async {
    listSelctedMapel.clear();

    var data = await ApiService.getMapel(
        selectedJenjang, selectedKelas, selectedMapel, "pts");

    for (var element in data) {
      listSelctedMapel.add(element);
    }

    notifyListeners();
  }
    getListMapelPAS( ) async {
    listSelctedMapelPas.clear();

    var data = await ApiService.getMapel(
        selectedJenjang, selectedKelas, selectedMapel, "pas");

    for (var element in data) {
      listSelctedMapelPas.add(element);
    }

    notifyListeners();
  }
}
