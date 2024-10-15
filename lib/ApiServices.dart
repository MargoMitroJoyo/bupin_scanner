import 'dart:developer';

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
  'SD I',
  'SD II',
  'SD III',
  'SD IV',
  'SD V',
  'SD VI',
  'SMP VII',
  "SMP VIII",
  "SMP IX",
  "SMA X",
  "SMA XI",
  "SMA XII"
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

  static Future<List<String>> getMapelList(String jenjang, int kelas) async {
    final dio = Dio();
    String newLink = "https://cbt.api.bupin.id/api/mapel/lists";

    final response = await dio.get(newLink,
        queryParameters: {"level": jenjang, "kelas": kelas.toString()});

    List<String> temp = [];
    var data = response.data;
    for (var element in data) {
      temp.add(element.toString());
    }
    return temp;
  }

  static Future<List<Mapel>> getMapel(
      String jenjang, int kelas, String mapel, String type) async {
    final dio = Dio();
    String newLink = "https://cbt.api.bupin.id/api/mapel/";

    final response = await dio.get(newLink, queryParameters: {
      "level": jenjang,
      "kelas": kelas.toString(),
      "mapel": mapel,
      "type": type
    });
    log(response.data.toString());
    List<Mapel> temp = [];
    var data = response.data;
    for (var element in data["data"]) {
      if (!temp.map((e) => e.nama,) .contains(element["nama"])) {
        temp.add(Mapel.fromMap(element));
      }
    }
    return temp;
  }

  static Future<Quiz> getUjian(
    String link,
  ) async {
    log(link);
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

  static Future<Quiz> detailPtsPas(
      String link, String namaKelas, String namaBab, String namaMapel) async {
    log(link);
    final dio = Dio();

    final response = await dio.get(link);

    log(response.data.toString());
    return Quiz.fromMap(
        {"namaKelas": namaKelas, "namaBab": namaBab, "namaMapel": namaMapel},
        response.data);
  }

  pushToVideo(String link, BuildContext context) {
    Navigator.of(context).push(CustomRoute(
      builder: (context) => HalamanVideo(link),
    ));
    return;
  }

  pushToCbt(String scanResult, BuildContext context) {
    log(scanResult);
    Navigator.of(context).push(CustomRoute(
      builder: (context) => HalamanSoal(
        link: scanResult,
      ),
    ));
    return;
  }
}
