class RecentSoal {
  final String? namaBab;
  final String? namaMapel;
  final String link;

  RecentSoal({required this.namaBab, required this.namaMapel,  required this.link,});
  factory RecentSoal.fromMap(Map<String, dynamic> data) {
    return RecentSoal(
      namaBab:   data["namaBab"], namaMapel:  data["namaMapel"],
      link:  data["link"]);
  }
  static Map<String, dynamic> toJson(RecentSoal instance) => {
        "namaBab": instance.namaBab,
        "namaMapel": instance.namaMapel,
        "link": instance.link
      };
}
