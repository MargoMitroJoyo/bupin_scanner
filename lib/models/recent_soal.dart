import 'package:Bupin/helper/capital.dart';

class RecentSoal {
  final String? namaBab;
  final String? namaMapel;
  final String link;
  final String kelas;

  final int correctAswer;
  RecentSoal(
      {required this.namaBab,
      required this.correctAswer,
      required this.namaMapel,
      required this.link,
      required this.kelas});
  factory RecentSoal.fromMap(
    Map<String, dynamic> data,
  ) {
    return RecentSoal(
        namaBab: data["namaBab"],
        correctAswer: data["correctAnswer"] ?? 0,
        namaMapel: data["namaMapel"],
        kelas: data["namaKelas"],
        link: data["link"]);
  }
  static Map<String, dynamic> toJson(RecentSoal instance) => {
        "namaBab": instance.namaBab,
        "namaMapel": instance.namaMapel,
        "correctAnswer": instance.correctAswer,
        "link": instance.link,
        "namaKelas": instance.kelas
      };
}
