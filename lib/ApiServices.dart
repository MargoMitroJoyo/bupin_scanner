import 'dart:developer';

import 'package:Bupin/helper/capital.dart';
import 'package:Bupin/quiz/Halaman_Soal.dart';
import 'package:Bupin/youtube_video/Halaman_Video.dart';
import 'package:Bupin/models/het.dart';
import 'package:Bupin/models/mapel.dart';
import 'package:Bupin/models/video.dart';
import 'package:Bupin/models/soal.dart';
import 'package:Bupin/styles/PageTransitionTheme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const List<String> list = <String>[
  'SD/MI  I',
  'SD/MI  II',
  'SD/MI  III',
  'SD/MI  IV',
  'SD/MI  V',
  'SD/MI  VI',
  'SMP/MTS  VII',
  "SMP/MTS  VIII",
  "SMP/MTS  IX",
  "SMA/MA  X",
  "SMA/MA  XI",
  "SMA/MA  XII"
];
const List<String> listKelas = <String>[
  'I',
  'II',
  'III',
  'IV',
  'V',
  'VI',
  'VII',
  "VIII",
  "IX",
  "X",
  "XI",
  "XII"
];

class ApiService {
  static List<Mapel>? listMapel;

  Map<String, dynamic> eventData = {};
  Future<void> getMapel() async {
    final dio = Dio();
    final response = await dio.get(
        "https://bupin.id/api/apigurupintar/api-materipusat.php?kode_sekolah=PUSAT-12345&id_kelas=72");

    if (response.data == null) {
      return;
    } else {
      List<Mapel> tempListMapel = [];

      for (Map<String, dynamic> element in response.data) {
        if (!tempListMapel
            .map((e) => e.mapel)
            .toList()
            .contains(element["mapel"])) {
          log(element["mapel"] + " Mapel");
          tempListMapel.add(Mapel.fromMap(element));
        }
      }
      listMapel = tempListMapel;
      ;
      return;
    }
  }

  Future<List<Het>> fetchHet(String dropdownValue) async {
    try {
      List<Het> listHet = [];
      final dio = Dio();
      int data = list.indexOf(dropdownValue);
      final response =
          await dio.get("https://bupin.id/api/het?kelas=${listKelas[data]}");

      if (response.statusCode == 200) {
        for (Map<String, dynamic> element in response.data) {
          listHet.add(Het.fromMap(element));
        }

        return listHet;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<String> fetchCs() async {
    try {
      final dio = Dio();

      final response = await dio.get("https://bupin.id/api/cs/");

      if (response.statusCode == 200) {
        return response.data[0]["num"];
      } else {
        return "6282171685885";
      }
    } catch (e) {
      return "6282171685885";
    }
  }

  static Future<Map<String, dynamic>> checkBanner() async {
    try {
      final dio = Dio();
      final response = await dio.get("https://bupin.id/api/banner/");

      return response.data[0];
    } catch (e) {
      return {};
    }
  }

  static Future<Map<String, dynamic>> checkEvent() async {
    try {
      final dio = Dio();
      final response = await dio.get("https://bupin.id/api/fab/");

      return response.data[0];
    } catch (e) {
      return {};
    }
  }

  static Future<Map<String, dynamic>?> isVertical(Video video) async {
    final dio = Dio();
    final response = await dio.get(
        "https://www.googleapis.com/youtube/v3/videos?part=snippet&id=${video.ytId}&key=AIzaSyDgsDwiV1qvlNa7aes8aR1KFzRSWLlP6Bw");

    return {
      "imageUrl": response.data["items"][0]["snippet"]["thumbnails"]["medium"]
          ["url"],
      "isVertical": (response.data["items"][0]["snippet"]["localized"]
              ["description"] as String)
          .contains("ctv")
    };
  }

  static Future<Quiz> getUjian(String link) async {
    final dio = Dio();
    String newLink =
        link.replaceRange(0, 22, "https://buku.bupin.id/api/ujn.php");
    log(newLink);
    final response = await dio.get(newLink);

    String jenjang = "sd";
    if ((response.data["namaKelas"] as String).contains("SD")) {
      jenjang = "sd";
    }
    if ((response.data["namaKelas"] as String).contains("SMP")) {
      jenjang = "smp";
    }
    if ((response.data["namaKelas"] as String).contains("SMA")) {
      jenjang = "sma";
    }
    final response2 = await dio.get(
        "https://cbt.api.bupin.id/api/mapel/${response.data["idUjian"]}?level=$jenjang");

    return Quiz.fromMap(response.data, response2.data);
  }

  Future<bool> pushToVideo(String link, BuildContext context) async {
    return await Navigator.of(context).push(CustomRoute(
      builder: (context) => HalamanVideo(link),
    ));
  }

  Future<bool> pushToCbt(
      String scanResult, String jenjang, BuildContext context) async {
    log(scanResult);
    Quiz data = await getUjian(scanResult);
    return await Navigator.of(context).push(CustomRoute(
      builder: (context) => HalamanSoal(
        questionlenght: data.questions,
        namaBab: data.namaBab,
        namaMapel: data.namaMapel.toTitleCase(),
        color: Theme.of(context).primaryColor,
      ),
    ));
  }

  Future<bool> scanQrCbt(String link, BuildContext context) async {
    return await pushToCbt(link, "jenjang", context);
  }

  Future<bool> scanQrVideo(String link, BuildContext context) async {
    return await pushToVideo(link, context);
  }
}
