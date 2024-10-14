import 'dart:developer';

import 'package:Bupin/models/het.dart';
import 'package:Bupin/quiz/pdf_soal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'dart:collection' as c;
import 'package:Bupin/ApiServices.dart';
import 'package:collection/collection.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart' as intl;

class HET extends StatefulWidget {
  const HET({Key? key}) : super(key: key);

  @override
  State<HET> createState() => _HETState();
}

class _HETState extends State<HET> {
  List<Het> listHET = [];
  String dropdownValue = list.first;
  RegExp romanNumerals = RegExp(r"\b[IVXLCDM]+\b");
  Future<void> fetchApi() async {
    try {
      listHET.clear();
      final dio = Dio();
      int data = list.indexOf(dropdownValue);
      final response =
          await dio.get("https://bupin.id/api/het?kelas=${listKelas[data]}");

      if (response.statusCode == 200) {
        for (Map<String, dynamic> element in response.data) {
          if (!listHET
              .map(
                (e) => e.imgUrl,
              )
              .contains(element["cover"])) {
            listHET.add(Het.fromMap(element));
          }
        }
        listHET.sort((a, b) => a.namaBuku.compareTo(b.namaBuku));
        setState(() {});
      }
    } catch (e) {
      log("errrorrr");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchApi();
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

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
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: GridView(
                    padding: EdgeInsets.only(top: 30),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 2,
                        crossAxisCount: 2,
                        childAspectRatio: 0.8),
                    children: listHET
                        .map((e) => Container(
                              child: InkWell(
                                  onTap: () {
                                    _launchInBrowser(Uri.parse(e.pdf));
                                  },
                                  child: Container(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.30,
                                            margin: const EdgeInsets.only(
                                                bottom: 8),
                                            child: Container(
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: FadeInImage(
                                                    imageErrorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                        "asset/place.png",
                                                      );
                                                    },
                                                    image: NetworkImage(
                                                      e.imgUrl,
                                                    ),
                                                    placeholder:
                                                        const AssetImage(
                                                      "asset/place.png",
                                                    ),
                                                  )),
                                            ),
                                          ),
                                          Center(
                                              child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.30,
                                            child: Text(
                                              e.namaBuku
                                                  .replaceAll("KMA-MI", "")
                                                  .replaceAll("SD/MI", "")
                                                  .replaceAll("KELAS", "")
                                                  .replaceAll("KMA-MA", "")
                                                  .replaceAll("SMA/MA", "")
                                                  .replaceAll("KMA-MTS", "")
                                                  .replaceAll(romanNumerals, "")
                                                  .replaceAll("SMP/MTS", ""),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Color.fromARGB(
                                                    255, 66, 66, 66),
                                                fontSize: 12,
                                                overflow: TextOverflow.fade,
                                              ),
                                            ),
                                          )),
                                        ]),
                                  )),
                            ))
                        .toList(),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.3 * 9 / 16,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300)),
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            "asset/Halaman_HET/Logo Kurmer.png",
                            width: MediaQuery.of(context).size.width * 0.22,
                            alignment: Alignment.center,
                          ),
                        ),
                        Container(
                          height:
                              MediaQuery.of(context).size.width * 0.19 * 9 / 16,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButton<String>(
                            padding: EdgeInsets.zero,
                            value: dropdownValue,
                            dropdownColor: Colors.white,
                            iconEnabledColor:
                                const Color.fromARGB(255, 66, 66, 66),
                            icon: const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.arrow_drop_down_rounded,
                                size: 20,
                                weight: 10,
                              ),
                            ),
                            elevation: 16,
                            style: const TextStyle(
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w700,
                                color: Color.fromARGB(255, 66, 66, 66)),
                            underline: Container(
                              height: 0,
                              color: Colors.transparent,
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.

                              dropdownValue = value!;
                              setState(() {});
                              fetchApi();
                            },
                            items: list
                                .map<DropdownMenuItem<String>>((String value) {
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomAppBar extends StatelessWidget {
  double top = 0;
  final List<Widget> sliders = [
    Image.asset(
      "asset/2.png",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "asset/3.png",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "asset/1.png",
      fit: BoxFit.cover,
    ),
  ];
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
              titlePadding: EdgeInsets.all(0),
              title: AnimatedOpacity(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'asset/sibi.png',color: Colors.white,
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                    ),
                  ],
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
                                    fontSize: 28,
                                    fontFamily: "Rubik",
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "E-book dari Kemendikbud & Kemenag\nSemuanya dalam genggaman",
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
