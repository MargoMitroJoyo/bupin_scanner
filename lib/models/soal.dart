import 'dart:developer';

import 'package:Bupin/models/helper.dart';

class WidgetQuestion {
  final String imageUrl;
  final String text;
  final List<WiidgetOption> options;
  bool isLocked;
  WiidgetOption? selectedWiidgetOption;
  WiidgetOption correctAnswer;

  WidgetQuestion({
    required this.imageUrl,
    required this.text,
    required this.options,
    this.isLocked = false,
    this.selectedWiidgetOption,
    required this.correctAnswer,
  });
  factory WidgetQuestion.fromMap(Map<String, dynamic> data) {
    return WidgetQuestion(
        text: data["soal"],
           
        options: [
          WiidgetOption(
            isCorrect: data["jawaban"] == "pilA",
            text:data["pilA"],
          ),
          WiidgetOption(
            isCorrect: data["jawaban"] == "pilB",
            text: (data["pilB"])
                .replaceAll("<strong>", "")
                .replaceAll("</strong>", "")
                .replaceAll("<br>", "")
                .replaceAll("<p>", "")
                .replaceAll("</p>", ""),
          ),
          WiidgetOption(
            isCorrect: data["jawaban"] == "pilC",
            text: (data["pilC"])
                .replaceAll("<strong>", "")
                .replaceAll("</strong>", "")
                .replaceAll("<br>", "")
                .replaceAll("<p>", "")
                .replaceAll("</p>", ""),
          ),
          WiidgetOption(
            isCorrect: data["jawaban"] == ("pilD"),
            text: data["pilD"]
                .replaceAll("<strong>", "")
                .replaceAll("</strong>", "")
                .replaceAll("<br>", "")
                .replaceAll("<p>", "")
                .replaceAll("</p>", ""),
          ),
          WiidgetOption(
            isCorrect: data["jawaban"] == ("pilE"),
            text: data["pilE"]
                .replaceAll("<strong>", "")
                .replaceAll("</strong>", "")
                .replaceAll("<br>", "")
                .replaceAll("<p>", "")
                .replaceAll("</p>", ""),
          )
        ],
        imageUrl: data["soal"],
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
