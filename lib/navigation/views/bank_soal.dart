import 'dart:developer';

import 'package:Bupin/bank_soal/Halaman_PTS&PAS.dart';
import 'package:Bupin/bank_soal/custom_button.dart';
import 'package:Bupin/helper/helper.dart';
import 'package:Bupin/styles/PageTransitionTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:Bupin/ApiServices.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

import 'package:url_launcher/url_launcher.dart';

class BankSoal extends StatefulWidget {
  BankSoal({Key? key}) : super(key: key);

  @override
  State<BankSoal> createState() => _BankSoalState();
}

class _BankSoalState extends State<BankSoal> {
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  String dropdownValue = list.first;

  List<String> subjects = [
    'Bahasa Indonesia',
    'Bahasa Inggris',
    'Bahasa Jawa',
    'Bahasa Jawa Timur',
    'Bahasa Sunda',
    'Biologi',
    'Fisika',
    'Kimia',
    // 'IPA',
    // 'IPAS',
    'Informatika',
    'Matematika',
    // 'Matematika Peminatan',
    // 'IPS',
    'Geografi',
    'Ekonomi',
    'Antropologi',
    'Sosiologi',
    'Sejarah',
    // 'Sejarah Indonesia',
    // 'Seni Budaya',
    'Seni Musik',
    'Seni Rupa',
    'Penjas',
    //  'Prakarya',
    'Pendidikan Pancasila',
    // 'PKWU',

    // 'BK',
    'Bahasa Arab',
    // 'BTQ',
    // 'Akidah Akhlak',
    // 'Fikih',
    // 'PAIBP',
    // 'Qurdis',
    // 'SKI',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Image.asset("asset/4.png"),
          NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [HomAppBar()];
              },
              body: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top * 1.5),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 237, 240, 247),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    width: MediaQuery.of(context).size.width,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: ListView(padding: EdgeInsets.zero, children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade300))),
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Banksoal",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        Text(
                                          "PTS/PAS",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: const Color.fromARGB(
                                                  255, 66, 66, 66)),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.19 *
                                              9 /
                                              16,
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: DropdownButton<String>(
                                        padding: EdgeInsets.zero,
                                        value: dropdownValue,
                                        dropdownColor: Colors.white,
                                        iconEnabledColor: const Color.fromARGB(
                                            255, 66, 66, 66),
                                        icon: const Padding(
                                          padding: EdgeInsets.only(left: 0),
                                          child: Icon(
                                            Icons.arrow_drop_down_rounded,
                                            size: 20,
                                            color:
                                                Color.fromARGB(255, 81, 87, 97),
                                            weight: 10,
                                          ),
                                        ),
                                        elevation: 16,
                                        style: const TextStyle(
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.w700,
                                          color:
                                              Color.fromARGB(255, 81, 87, 97),
                                        ),
                                        underline: Container(
                                          height: 0,
                                          color: Colors.transparent,
                                        ),
                                        onChanged: (String? value) {
                                          // This is called when the user selects an item.

                                          dropdownValue = value!;
                                          setState(() {});
                                          // fetchApi();
                                        },
                                        items: list
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  child: Container(
                                      child: GridView.builder(
                                          padding: const EdgeInsets.only(
                                              top: 25, right: 5, left: 5),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 1.8),
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: subjects.length,
                                          itemBuilder:
                                              (context, index) =>CustomButton(subjects[index]),
                                                 ))),
                            ],
                          ),
                        ),
                      ])),
                ],
              )),
        ],
      ),
    );
  }
}

class HomAppBar extends StatelessWidget {
  double top = 0;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        stretch: true,
        expandedHeight: MediaQuery.of(context).size.height * 0.15,
        floating: false,
        actions: [],
        pinned: true,
        flexibleSpace: Stack(alignment: Alignment.topCenter, children: [
          Positioned.fill(
              child: Image.asset(
            "asset/4.png",
            fit: BoxFit.fitWidth,
          )),
          LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            top = constraints.biggest.height;
            log(top.toString());
            return FlexibleSpaceBar(
              titlePadding: EdgeInsets.all(10),
              title: AnimatedOpacity(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [],
                ),
                duration: const Duration(milliseconds: 200),
                opacity:
                    top <= MediaQuery.of(context).padding.top + kToolbarHeight
                        ? 1.0
                        : 0.0,
              ),
              background: Container(
                color: Colors.white,
                child: OverflowBox(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned.fill(
                          child: Image.asset(
                        "asset/4.png",
                        fit: BoxFit.fitWidth,
                      )),
                      SafeArea(
                        child: Center(
                            child: Padding(
                          padding: EdgeInsets.only(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Halo, Steve!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Rubik",
                                  fontSize: 28,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "Persiapkan ujian dengan ribuan banksoal\n Disediakan oleh Bupin 4.0",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    height: 0,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                      )
                    ],
                  ),
                ),
              ),
            );
          })
        ]));
  }
}
