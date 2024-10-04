import 'dart:developer';

import 'package:Bupin/helper.dart';

class WidgetQuestion {
  final List<String> text;
  final String htmlText;
  final List<WiidgetOption> options;
  bool isLocked;
  WiidgetOption? selectedWiidgetOption;
  WiidgetOption correctAnswer;

  WidgetQuestion({
    required this.htmlText,
    required this.text,
    required this.options,
    this.isLocked = false,
    this.selectedWiidgetOption,
    required this.correctAnswer,
  });
  
  factory WidgetQuestion.fromMap(Map<String, dynamic> data) {
    return WidgetQuestion(htmlText:data["soal"] ,
        text: Helper.convertSoal(data["soal"])
            .map(
              (e) => e
                  .replaceAll("<strong>", "")
                  .replaceAll("</strong>", "")
                  .replaceAll("<br>", "")
                  .replaceAll("<p>", "")
                  .replaceAll("</p>", ""),
            )
            .toList(),
        options: [
          WiidgetOption(
            isCorrect: data["jawaban"] == "pilA",
            text: data["pilA"]
             
          ),
          WiidgetOption(
            isCorrect: data["jawaban"] == "pilB",
            text: (data["pilB"])
             
          ),
          WiidgetOption(
            isCorrect: data["jawaban"] == "pilC",
            text: (data["pilC"])
             
          ),
          WiidgetOption(
            isCorrect: data["jawaban"] == ("pilD"),
            text: data["pilD"]
             
          ),
          WiidgetOption(
            isCorrect: data["jawaban"] == ("pilE"),
            text: data["pilE"]
             
          )
        ],
     
        correctAnswer: WiidgetOption(isCorrect: true, text: data["jawaban"]));
  }
}

class WiidgetOption {
  final String? text;
  final bool? isCorrect;

  const WiidgetOption({
    this.text,
    this.isCorrect,
  });
}
