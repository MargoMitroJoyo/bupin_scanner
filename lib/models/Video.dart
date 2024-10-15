import 'package:Bupin/helper/helper.dart';
import 'package:Bupin/navigation/component/recent_video_item.dart';

class Video {
  final String? ytId;
  final String? namaVideo;
  final String? linkVideo;
  String? namaMapel;
  String namaKelas;

  Video(this.ytId, this.namaVideo, this.namaMapel, this.linkVideo,this.namaKelas);
  factory Video.fromMap(Map<String, dynamic> data) {
    return Video(
        (data["ytid"] == null) ? (data["ytidDmp"]) : (data["ytid"]),
        (data["nama_bab"]),
        data["nama_mapel"],
        (data["link_video"] == null)
            ? data["linkDmp"]
            : "https://www.youtube.com/watch?v=${data["ytid"]}",
            
           data["nama_kelas"]);
  }
}
