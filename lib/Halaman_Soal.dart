import 'dart:async';
import 'dart:typed_data';

import 'package:Bupin/Halaman_PDF_Soal.dart';
import 'package:Bupin/models/soal.dart';
import 'package:Bupin/widgets/image_memory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';

import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

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
  final String topicType;
  final List<dynamic> questionlenght;
  final Color color;
  const HalamanSoal(
      {super.key,
      required this.color,
      required this.questionlenght,
      required this.topicType});

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
  int questionTimerSeconds = 60;
  Timer? _timer;
  int _questionNumber = 1;
  PageController _controller = PageController();
  int score = 0;
  bool isLocked = false;
  List optionsLetters = ["A.", "B.", "C.", "D.", "E."];
  List<WiidgetOption> listSelectedOption = [];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    _resetQuestionLocks();
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor3 = widget.color;
    Color bgColor = widget.color.withOpacity(0.5);

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: bgColor3,
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
                                  // controller.pause();
                                  Navigator.pop(context, false);
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
                            child: Flexible(
                              child: Text(
                                "${widget.topicType}",
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
                          child: Center(
                            child: Text(
                              "Pertanyaan $_questionNumber/${widget.questionlenght.length}",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey.shade500),
                            ),
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
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: PageView.builder(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            pageSnapping: false,
            itemCount: widget.questionlenght.length,
            onPageChanged: (value) {
              // setState(() {
              _questionNumber = value + 1;
              isLocked = false;
              _resetQuestionLocks();
              // });
            },
            itemBuilder: (context, index) {
              final WidgetQuestion myquestions = widget.questionlenght[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    HtmlWidget(
                                // the first parameter (`html`) is required
                                 myquestions.text, 
  

                                // all other parameters are optional, a few notable params:

                                // specify custom styling for an element
                                // see supported inline styling below
                              
                              

                                // this callback will be triggered when user taps a link

                                // select the render mode for HTML body
                                // by default, a simple `Column` is rendered
                                // consider using `ListView` or `SliverList` for better performance
                                renderMode: RenderMode.column,

                                // set the default styling for text
                                textStyle: TextStyle(fontSize: 14),
                              ),
                            
                            
                    const SizedBox(
                      height: 25,
                    ),
                    Column(
                      children: myquestions.options.map((e) {
                        var color = Colors.grey.shade200;

                        var questionOption = e;
                        final letters =
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
                        return questionOption.text!.isEmpty?SizedBox(): InkWell(
                          onTap: () {
                            if (!myquestions.isLocked) {
                              listSelectedOption.add(questionOption);
                              setState(() {
                                myquestions.isLocked = true;
                                myquestions.selectedWiidgetOption =
                                    questionOption;
                              });

                              isLocked = myquestions.isLocked;
                              if (myquestions
                                  .selectedWiidgetOption!.isCorrect!) {
                                score++;
                              }
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: color),
                              color: Colors.grey.shade100,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Center(
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      "$letters",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  // questionOption.text!.contains("data:image")
                                  //     ? Expanded(
                                  //         child: Padding(
                                  //           padding:
                                  //               const EdgeInsets.only(left: 10),
                                  //           child: ClipRRect(
                                  //               borderRadius:
                                  //                   BorderRadius.circular(5),
                                  //               child: AspectRatio(
                                  //                 aspectRatio: 16 / 9,
                                  //                 child: Base64Image( questionOption.text!),
                                  //               )),
                                  //         ),
                                  //       )
                                  //     :

                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 4),
                                      child: HtmlWidget(
                                // the first parameter (`html`) is required
                                questionOption.text!,

                                // all other parameters are optional, a few notable params:

                                // specify custom styling for an element
                                // see supported inline styling below
                              
                              

                                // this callback will be triggered when user taps a link

                                // select the render mode for HTML body
                                // by default, a simple `Column` is rendered
                                // consider using `ListView` or `SliverList` for better performance
                                renderMode: RenderMode.column,

                                // set the default styling for text
                                textStyle: TextStyle(fontSize: 14),
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
                    ),
                    isLocked
                        ? Center(
                            child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: buildElevatedButton(),
                          ))
                        : const SizedBox.shrink(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _resetQuestionLocks() {
    for (var question in widget.questionlenght) {
      question.isLocked = false;
    }
    questionTimerSeconds = 60;
  }

  ElevatedButton buildElevatedButton() {
    //  const Color bgColor3 = Color(0xFF5170FD);

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(widget.color),
        fixedSize: MaterialStateProperty.all(
          Size(MediaQuery.sizeOf(context).width * 0.80, 40),
        ),
        elevation: MaterialStateProperty.all(4),
      ),
      onPressed: () {
        if (_questionNumber < widget.questionlenght.length) {
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
              builder: (context) => HalamanPDFSoalState(widget.questionlenght,
                  listSelectedOption, widget.color, score, widget.topicType),
            ),
          );
        }
      },
      child: Text(
        _questionNumber < widget.questionlenght.length
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
