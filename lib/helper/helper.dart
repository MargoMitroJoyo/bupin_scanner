import 'dart:developer';

import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;

class Helper {
  static String stripHtmlIfNeeded(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
  }
 static  localAsset(String mapel) {
      if (mapel.toUpperCase().contains("PRAKARYA")) {
        return "asset/Icon/Fisika.png";
      }
      if (mapel.toUpperCase().contains("AGAMA") ||
          mapel.toUpperCase().contains("ARAB") ||
          mapel.toUpperCase().contains("AKIDAH") ||
          mapel.toUpperCase().contains("QUR'AN") ||
          mapel.toUpperCase().contains("PAI")) {
        return "asset/Icon/Agama.png";
      }

      if (mapel.toUpperCase().contains("INDONESIA")) {
        return "asset/Icon/Bahasa Indonesia.png";
      }
      if (mapel.toUpperCase().contains("JAWA")) {
        return "asset/Icon/Jawa.png";
      }
      if (mapel.toUpperCase().contains("MATEMATIKA")) {
        return "asset/Icon/Matematika.png";
      }
      if (mapel.toUpperCase().contains("INGGRIS")) {
        return "asset/Icon/Bahasa Inggris.png";
      }
      if (mapel.toUpperCase().contains("IPA") ||
          mapel.toUpperCase().contains("ALAM") ||
          mapel.toUpperCase().contains("FISIKA")) {
        return "asset/Icon/Fisika.png";
      }
      if (mapel.toUpperCase().contains("IPS") ||
          mapel.toUpperCase().contains("SOSIAL")) {
        return "asset/Icon/Geografi.png";
      }
      if (mapel.toUpperCase().contains("KIMIA")) {
        return "asset/Icon/Kimia.png";
      }
      if (mapel.toUpperCase().contains("BIOLOGI")) {
        return "asset/Icon/Biologi.png";
      }

      if (mapel.toUpperCase().contains("KIMIA")) {
        return "asset/Icon/Kimia.png";
      }
      if (mapel.toUpperCase().contains("ANTROPOLOGI")) {
        return "asset/Icon/Antropologi.png";
      }
      if (mapel.toUpperCase().contains("EKONOMI")) {
        return "asset/Icon/Ekonomi.png";
      }
      if (mapel.toUpperCase().contains("PANCASILA")) {
        return "asset/Icon/Pancasila.png";
      }
      if (mapel.toUpperCase().contains("SOSIOLOGI")) {
        return "asset/Icon/Sosiologi.png";
      }
      if (mapel.toUpperCase().contains("SEJARAH")) {
        return "asset/Icon/Sejarah.png";
      }
      return "asset/Icon/Bahasa Indonesia.png";
    }

   static String localMapelName(String mapel) {
      if (mapel.toUpperCase().contains("PRAKARYA")) {
        return "asset/Icon/Fisika.png";
      }
      if (mapel.toUpperCase().contains("AGAMA") ||
          mapel.toUpperCase().contains("ARAB") ||
          mapel.toUpperCase().contains("AKIDAH") ||
          mapel.toUpperCase().contains("QUR'AN") ||
          mapel.toUpperCase().contains("PAI")) {
        return "PAI";
      }

      if (mapel.toUpperCase().contains("INDONESIA")) {
        return "Indonesia";
      }
      if (mapel.toUpperCase().contains("MATEMATIKA")) {
        return "Matematika";
      }
      if (mapel.toUpperCase().contains("INGGRIS")) {
        return "Inggris";
      }
      if (mapel.toUpperCase().contains("IPA") ||
          mapel.toUpperCase().contains("ALAM") ||
          mapel.toUpperCase().contains("FISIKA")) {
        return "IPA";
      }
      if (mapel.toUpperCase().contains("FISIKA")) {
        return "Fisika";
      }
      if (mapel.toUpperCase().contains("IPS") ||
          mapel.toUpperCase().contains("SOSIAL")) {
        return "IPS";
      }
      if (mapel.toUpperCase().contains("KIMIA")) {
        return "Kimia";
      }
      if (mapel.toUpperCase().contains("BIOLOGI")) {
        return "Biologi";
      }

      if (mapel.toUpperCase().contains("ANTROPOLOGI")) {
        return "Antropologi";
      }
      if (mapel.toUpperCase().contains("EKONOMI")) {
        return "Ekonomi";
      }
      if (mapel.toUpperCase().contains("PANCASILA")) {
        return "PPKN";
      }
      if (mapel.toUpperCase().contains("SOSIOLOGI")) {
        return "Sosiologi";
      }
      if (mapel.toUpperCase().contains("SEJARAH")) {
        return "Sejarah";
      }
      return mapel;
    }
  static List<String> convertSoal(String soal) {if(soal.isEmpty){
      return [soal];
    }
    List<String> list = [];
    var document = parse(soal);
    for (var i = 0; i < document.querySelectorAll("p").length; i++) {
      var data = document.querySelectorAll("p")[i].innerHtml.toString();
      if (data.contains("img src")) {
        var image = document.querySelectorAll("p")[i];
        dom.Element? link = image.querySelector('img');
        String? imageLink = link != null ? link.attributes['src'] : "";
        list.add(imageLink.toString());
      } else {
        list.add(document.querySelectorAll("p")[i].text);
      }
    }
    return list;
  }

  static String convertSoal2(String soal) {
    final String str = 'Jeremiah  52:1\\u2013340';
    final Pattern unicodePattern = new RegExp(r'\\u([0-9A-Fa-f]{4})');
    final String newStr =
        soal.replaceAllMapped(unicodePattern, (Match unicodeMatch) {
      final int hexCode = int.parse(unicodeMatch.group(1)!, radix: 16);
      final unicode = String.fromCharCode(hexCode);
      return unicode;
    });
    print('Old string: $soal');
    print('New string: $newStr');
    return newStr;
  }

  static String printDuration(Duration duration) {
    String negativeSign = duration.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return "$negativeSign${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
