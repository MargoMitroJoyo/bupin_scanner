class RecentVideo {
  final String link;
  final String imageUrl;
  final String namaSubBab;
  final String namaKelas;
  final String namaMapel;
  final Duration recentDuration;
  final Duration totalDuration;

  RecentVideo(this.link, this.imageUrl, this.namaSubBab, this.recentDuration,
      this.totalDuration, this.namaKelas, this.namaMapel);
  factory RecentVideo.fromMap(Map<String, dynamic> data) {
    return RecentVideo(
        data["link"],
        data["imageUrl"],
        data["namaSubBab"],
        Duration(seconds: int.parse(data["recentDuration"])),
        Duration(seconds: int.parse(data["totalDuration"])),
        data["nama_kelas"]??"null",
        data["nama_mapel"]??"null");
  }
  static Map<String, dynamic> toJson(RecentVideo instance) => {
        "link": instance.link,
        "imageUrl": instance.imageUrl,
        "nama_kelas": instance.namaKelas,
        "nama_mapel": instance.namaMapel,
        "namaSubBab": instance.namaSubBab,
        "recentDuration": instance.recentDuration.inSeconds.toString(),
        "totalDuration": instance.totalDuration.inSeconds.toString()
      };
}
