class RecentSoal {
  final String? namaBab;
  final String? namaMapel;
final String imageAsset;
  RecentSoal(this.namaBab, this.namaMapel,this.imageAsset);
  factory RecentSoal.fromMap(Map<String, dynamic> data) {
    return RecentSoal(data["namaBab"], data["namaMapel"],data["imageAsset"]);
  }
  static Map<String, dynamic> toJson(RecentSoal instance) =>
      {"namaBab": instance.namaBab, "namaMapel": instance.namaMapel,"imageAsset":instance.imageAsset};
}
