import 'dart:developer';

import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;

class Helper {
  static String stripHtmlIfNeeded(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
  }

  static List<String> convertSoal(String soal) {
    List<String> list = [];
    var document = parse(soal);
    for (var i = 0; i < document.querySelectorAll("p").length; i++) {
      var data = document.querySelectorAll("p")[i].innerHtml.toString();
      if (data.contains("img src")) {
        var image = document.querySelectorAll("p")[i];
        dom.Element? link = image.querySelector('img');
        String? imageLink = link != null ? link.attributes['src'] : "";
        log(imageLink.toString().replaceAll("data:image/png;base64,", ""));
        list.add(imageLink.toString());
      } else {
        list.add(document.querySelectorAll("p")[i].innerHtml.toString());
        log(document.querySelectorAll("p")[i].innerHtml.toString());
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

  static  printDuration(Duration duration) {
    String negativeSign = duration.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return "$negativeSign$twoDigitMinutes:$twoDigitSeconds";
    return "$negativeSign${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";

  }
}
