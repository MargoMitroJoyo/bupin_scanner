class RecentSoal {
  final String? namaBab;
  final String? namaMapel;
  final String imageAsset;
  final String link;

  RecentSoal(this.namaBab, this.namaMapel, this.link, this.imageAsset);
  factory RecentSoal.fromMap(Map<String, dynamic> data) {
    return RecentSoal(
        data["namaBab"], data["namaMapel"], data["imageAsset"], data["link"]);
  }
  static Map<String, dynamic> toJson(RecentSoal instance) => {
        "namaBab": instance.namaBab,
        "namaMapel": instance.namaMapel,
        "imageAsset": instance.imageAsset,
        "link": instance.link
      };
}