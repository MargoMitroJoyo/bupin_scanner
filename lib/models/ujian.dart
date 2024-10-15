import 'dart:developer';

import 'package:Bupin/helper/capital.dart';
import 'package:Bupin/helper/helper.dart';

class Ujian {
  final List<WidgetQuestion> questions;
  final String namaBab;
  final String namaMapel;
  final String kelas;
  final String ptspas;

  Ujian({
    required this.questions,
    required this.namaBab,
    required this.namaMapel,
    required this.ptspas,
    this.kelas = "0",
  });

  factory Ujian.fromMap(Map<String, dynamic> data, Map<String, dynamic> data2) {
    return Ujian(
        kelas: data["namaKelas"] == null
            ? "0"
            : data["namaKelas"].toString().extractNumber(),
        ptspas: data["ptspas"],
        questions: (data2["data"]["soal"] as List<dynamic>)
            .map(
              (e) => WidgetQuestion.fromMap(e),
            )
            .toList(),
        namaBab: data["namaBab"],
        namaMapel: data["namaMapel"]);
  }
}

class WidgetQuestion {
  final List<String> text;
  final String htmlText;
  final List<WiidgetOption> options;
  WiidgetOption? selectedWiidgetOption;

  WidgetQuestion({
    required this.htmlText,
    required this.text,
    required this.options,
    this.selectedWiidgetOption,
  });

  factory WidgetQuestion.fromMap(Map<String, dynamic> data) {
    return WidgetQuestion(
      htmlText: data["soal"],
      text: Helper.convertToList(data["soal"]).map((e) => e).toList(),
      options: [
        WiidgetOption(
            isCorrect: data["jawaban"] == "pilA",
            text: data["pilA"]),
        WiidgetOption(
            isCorrect: data["jawaban"] == "pilB",
            text: data["pilB"]),
        WiidgetOption(
            isCorrect: data["jawaban"] == "pilC",
            text: data["pilC"]),
        WiidgetOption(
            isCorrect: data["jawaban"] == ("pilD"),
            text: data["pilD"]),
        WiidgetOption(
            isCorrect: data["jawaban"] == ("pilE"),
            text: data["pilE"])
      ],
    );
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
