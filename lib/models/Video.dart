class Video {
  final String? ytId;
  final String? namaVideo;
  final String? linkVideo;
   String? namaMapel;

  Video(this.ytId, this.namaVideo, this.namaMapel ,this.linkVideo);
  factory Video.fromMap(Map<String, dynamic> data) {
    return Video(
        (data["ytid"] == null) ? (data["ytidDmp"]) : (data["ytid"]),
        (data["namaSubBab"]),data["namaMapel"],
           
        (data["linkVideo"] == null) ? data["linkDmp"] : "https://www.youtube.com/watch?v=${data["ytid"]}");
  }
}
