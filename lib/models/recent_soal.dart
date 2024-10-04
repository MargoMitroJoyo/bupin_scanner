class RecentSoal {
  final String? id;
  final String? namaBab;
  final String? namaMapel;

  RecentSoal(this.id, this.namaBab, this.namaMapel);
  factory RecentSoal.fromMap(Map<String, dynamic> data) {
    return RecentSoal(
        data["idUjian"], data["namaBab"], data["namaMapel"]);
  }
  static  Map<String,dynamic> toJson(RecentSoal instance)=>{"idUjian":instance.id,"namaBab":instance.namaBab,"namaMapel":instance.namaMapel };

}
