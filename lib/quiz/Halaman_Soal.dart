import 'dart:async';
import 'dart:typed_data';

import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/camera/camera_provider.dart';
import 'package:Bupin/helper/helper.dart';
import 'package:Bupin/models/recent_soal.dart';
import 'package:Bupin/quiz/Halaman_PDF_Soal.dart';
import 'package:Bupin/models/soal.dart';
import 'package:Bupin/widgets/image_memory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../navigation/navigation_provider.dart';

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}

class HalamanSoal extends StatefulWidget {
  final String link;
  const HalamanSoal({super.key, required this.link});

  @override
  State<HalamanSoal> createState() => _HalamanSoalState();
}

// The clip area can optionally be enlarged by a given padding.
class ClipPad extends CustomClipper<Rect> {
  final EdgeInsets padding;

  const ClipPad({this.padding = EdgeInsets.zero});

  @override
  Rect getClip(Size size) => padding.inflateRect(Offset.zero & size);

  @override
  bool shouldReclip(ClipPad oldClipper) => oldClipper.padding != padding;
}

class _HalamanSoalState extends State<HalamanSoal> {
  Quiz? data;
  int questionTimerSeconds = 60;
  Timer? _timer;
  int _questionNumber = 1;
  PageController _controller = PageController();
  int score = 0;
  bool isLocked = false;
  List optionsLetters = ["A.", "B.", "C.", "D.", "E."];
  List<WiidgetOption> listSelectedOption = [];
  bool loading = true;
  @override
  void initState() {
    getUjian();
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  getUjian() async {
    data = await ApiService.getUjian(widget.link);
    _resetQuestionLocks();

    loading = false;
    setState(() {});
  }

  recentSoal() {
    if (Provider.of<NavigationProvider>(context, listen: false)
            .selectedRecentSoal ==
        null) {
      Provider.of<NavigationProvider>(context, listen: false)
          .addRecentSoal(RecentSoal(
        namaBab: data!.namaBab,
        namaMapel: data!.namaMapel,
        link: widget.link,
      ));
    } else {
      // Provider.of<NavigationProvider>(context, listen: false)
      //     .updateRecentSoal(RecentSoal(
      //   data!.namaBab,
      //   data!.namaMapel,
      //   widget.link,
      //   Helper.localAsset(data!.namaMapel),
      // ));
    }
    Provider.of<NavigationProvider>(context, listen: false)
        .selectingRecentSoal = null;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        Provider.of<CameraProvider>(context, listen: false).scaning = false;
        recentSoal();
        Navigator.of(context).pop();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.2),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 14, bottom: 10),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: GestureDetector(
                                onTap: () {
                                  Provider.of<CameraProvider>(context,
                                          listen: false)
                                      .scaning = false;
                                  recentSoal();

                                  Navigator.of(context).pop();
                                },
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back_rounded,
                                    color: Colors.white,
                                    size: 20,
                                    weight: 100,
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: Text(
                              data?.namaBab ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ClipRect(
                      clipper: const ClipPad(padding: EdgeInsets.only(top: 30)),
                      child: Container(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.24),
                              blurRadius: 10.0,
                              offset: const Offset(10.0, 0),
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            loading
                                ? ""
                                : "Pertanyaan  $_questionNumber/${data?.questions.length ?? "0"}",
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey.shade500),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: loading
            ? Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ))
            : Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: PageView.builder(
                  controller: _controller,
                  physics: const NeverScrollableScrollPhysics(),
                  pageSnapping: false,
                  itemCount: data!.questions.length,
                  onPageChanged: (value) {
                    // setState(() {
                    _questionNumber = value + 1;
                    isLocked = false;
                    _resetQuestionLocks();
                    // });
                  },
                  itemBuilder: (context, index) {
                    final WidgetQuestion myquestions = data!.questions[index];

                    return ListView(
                        padding: const EdgeInsets.all(8.0),
                        children: [
                          //  HtmlWidget(myquestions.htmlText),
                          ...myquestions.text
                              .map(
                                (e) => e.contains("image/png")
                                    ? Base64Image(e)
                                    : Text(e),
                              )
                              .toList(),
                          const SizedBox(
                            height: 25,
                          ),
                          ...myquestions.options.map((e) {
                            var color = Colors.grey.shade200;

                            var questionOption = e;
                            String letters =
                                optionsLetters[myquestions.options.indexOf(e)];

                            if (myquestions.isLocked) {
                              if (questionOption ==
                                  myquestions.selectedWiidgetOption) {
                                color = questionOption.isCorrect!
                                    ? Colors.green
                                    : Colors.red;
                              } else if (questionOption.isCorrect!) {
                                color = Colors.green;
                              }
                            }
                            return (questionOption.text!.isEmpty &&
                                        letters == "E." ||
                                    questionOption.text!.isEmpty &&
                                        letters == "D.")
                                ? SizedBox()
                                : InkWell(
                                    onTap: () {
                                      if (!myquestions.isLocked) {
                                        listSelectedOption.add(questionOption);
                                        setState(() {
                                          myquestions.isLocked = true;
                                          myquestions.selectedWiidgetOption =
                                              questionOption;
                                        });

                                        isLocked = myquestions.isLocked;
                                        if (myquestions.selectedWiidgetOption!
                                            .isCorrect!) {
                                          score++;
                                        }
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: color),
                                        color: Colors.grey.shade100,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Center(
                                        child: Row(
                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                "$letters",
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 4),
                                                child: questionOption.text!
                                                        .contains(
                                                            "data:image/png;base64,")
                                                    ? Base64Image(
                                                        questionOption.text!)
                                                    : Text(
                                                        questionOption.text!,
                                                      ),
                                              ),
                                            ),
                                            isLocked == true
                                                ? questionOption.isCorrect!
                                                    ? const Icon(
                                                        Icons.check_circle,
                                                        color: Colors.green,
                                                      )
                                                    : const Icon(
                                                        Icons.cancel,
                                                        color: Colors.red,
                                                      )
                                                : Opacity(
                                                    opacity: 0,
                                                    child: const Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green,
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                          }).toList(),

                          isLocked
                              ? Center(
                                  child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: buildElevatedButton(),
                                ))
                              : const SizedBox.shrink(),
                        ]);
                  },
                ),
              ),
      ),
    );
  }

  void _resetQuestionLocks() {
    for (var question in data!.questions) {
      question.isLocked = false;
    }
    questionTimerSeconds = 60;
  }

  ElevatedButton buildElevatedButton() {
    //  const Color bgColor3 = Color(0xFF5170FD);

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).primaryColor),
        fixedSize: MaterialStateProperty.all(
          Size(MediaQuery.sizeOf(context).width * 0.80, 40),
        ),
        elevation: MaterialStateProperty.all(4),
      ),
      onPressed: () {
        if (_questionNumber < data!.questions.length) {
          _controller.nextPage(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
          setState(() {
            _questionNumber++;
            isLocked = false;
          });
          _resetQuestionLocks();
        } else {
          _timer?.cancel();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HalamanPDFSoalState(
                  data!,
                  listSelectedOption,
                  score,
                  data!.namaBab,
                  RecentSoal(
                    namaBab: data!.namaBab,
                    namaMapel: data!.namaMapel,
                    link: widget.link,
                  )),
            ),
          );
        }
      },
      child: Text(
        _questionNumber < data!.questions.length
            ? 'Selanjutnya'
            : 'Lihat Hasil',
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
