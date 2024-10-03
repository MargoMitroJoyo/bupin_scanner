import 'dart:developer';

import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;

class Helper {
static String stripHtmlIfNeeded(String text) {
  return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
}
static  List<String> convertSoal(String soal){
    List<String> list=[];
    var document=parse(soal);
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
  static  String convertSoal2(String soal){
  
    var document=parse(soal);
     
     
      if (soal.contains("data:image")) {
        var image = document.querySelector("img");
        dom.Element? link = image!.querySelector('img');
        String? imageLink = link != null ? link.attributes['src'] : "";
        log(imageLink.toString().replaceAll("data:image/png;base64,", ""));
      return imageLink!;
      } else {
        return soal;
      }
    
  }
}