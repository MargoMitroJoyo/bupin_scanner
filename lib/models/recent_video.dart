class RecentVideo {
  final String link;
  final String imageUrl;
  final String namaSubBab;
  final Duration recentDuration;
  final Duration totalDuration;

  RecentVideo(this.link, this.imageUrl, this.namaSubBab, this.recentDuration,
      this.totalDuration);
  factory RecentVideo.fromMap(Map<String, dynamic> data) {
    return RecentVideo(
        data["link"],
        data["imageUrl"],
        data["namaSubBab"],
        Duration(seconds: int.parse(data["recentDuration"])),
        Duration(seconds: int.parse(data["totalDuration"])));
  }
  static Map<String, dynamic> toJson(RecentVideo instance) => {
        "link": instance.link,
        "imageUrl": instance.imageUrl,
        "namaSubBab": instance.namaSubBab,
        "recentDuration": instance.recentDuration.inSeconds.toString(),
        "totalDuration": instance.totalDuration.inSeconds.toString()
      };
}
