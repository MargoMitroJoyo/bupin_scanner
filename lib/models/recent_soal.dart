import 'package:Bupin/helper/capital.dart';

class RecentSoal {
  final String? namaBab;
  final String? namaMapel;
  final String link;
  final String kelas;

  RecentSoal(
      {required this.namaBab,
      required this.namaMapel,
      required this.link,
   required   this.kelas});
  factory RecentSoal.fromMap(Map<String, dynamic> data,) {
    return RecentSoal(
        namaBab: data["namaBab"],
        namaMapel: data["namaMapel"],
        kelas:data["namaKelas"],
        link: data["link"]);
  }
  static Map<String, dynamic> toJson(RecentSoal instance) => {
        "namaBab": instance.namaBab,
        "namaMapel": instance.namaMapel,
        "link": instance.link,
        "namaKelas" :instance.kelas
      };
}
