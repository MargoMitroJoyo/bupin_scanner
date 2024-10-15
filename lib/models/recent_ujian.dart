import 'package:Bupin/helper/capital.dart';

class RecentUjian {
  final String? namaBab;
  final String? namaMapel;
  final String link;
  final String kelas;
  final String ptsPas;
  final int correctAswer;
  RecentUjian(
      {required this.namaBab,
      required this.namaMapel,
      required this.ptsPas,required this.correctAswer,
      required this.link,
      required this.kelas});
  factory RecentUjian.fromMap(
    Map<String, dynamic> data,
  ) {
    return RecentUjian(
        namaBab: data["namaBab"],
        namaMapel: data["namaMapel"], correctAswer: data["correctAnswer"]??0,
        ptsPas: data["ptspas"],
        kelas: data["namaKelas"],
        link: data["link"]);
  }
  static Map<String, dynamic> toJson(RecentUjian instance) => {
        "namaBab": instance.namaBab,"correctAnswer":instance.correctAswer,
        "namaMapel": instance.namaMapel,
        "link": instance.link,
        "ptspas": instance.ptsPas,
        "namaKelas": instance.kelas
      };
}
