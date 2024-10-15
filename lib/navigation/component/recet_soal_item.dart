import 'dart:developer';

import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/helper/capital.dart';
import 'package:Bupin/helper/helper.dart';

import 'package:Bupin/models/Video.dart';
import 'package:Bupin/models/recent_soal.dart';
import 'package:Bupin/models/recent_video.dart';
import 'package:Bupin/navigation/navigation_provider.dart';
import 'package:Bupin/quiz/Halaman_Soal.dart';
import 'package:Bupin/youtube_video/Halaman_Video.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

class RecenSoalItem extends StatelessWidget {
  final RecentSoal soal;

  RecenSoalItem(
    this.soal,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        height: MediaQuery.of(context).size.width * 0.19,
        child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1.5,
                    color: Helper.localColor(soal.namaMapel!).withOpacity(0.2)),
                borderRadius: BorderRadius.circular(15),
                color: Colors.white),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: AspectRatio(
                        aspectRatio: 16 / 16,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
                                Opacity(
                                    opacity: 1,
                                    child: Image.asset(
                                      "asset/Icon/Bg Icon2.png",
                                      color: Helper.localColor(soal.namaMapel!)
                                          .withOpacity(0.8),
                                    )),
                                // Opacity(
                                //     opacity:
                                //         0.3,
                                //     child: Image
                                //         .asset(
                                //             "asset/Icon/Bg t.png")),
                                Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Image.asset(
                                    Helper.localAsset(soal.namaMapel!),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacer(),
                      Spacer(),
                      Spacer(),
                      Text(
                        soal.namaBab!.toTitleCase(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color: Helper.localColor(soal.namaMapel!),
                            fontSize: 15,
                            fontFamily: "Rubik"),
                      ),
                      Spacer(),
                      Text(
                        "Kelas ${soal.kelas} ${soal.namaMapel!.toTitleCase()}",
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                      Spacer(),
                      Spacer(),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                    onTap: () {
                      log(soal.kelas);
                      Provider.of<NavigationProvider>(context, listen: false)
                          .selectedRecentSoal = soal;
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HalamanSoal(link: soal.link,ptspas: "pts",),
                      ));
                    },
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Helper.localColor(soal.namaMapel!),
                      size: 16,
                    )),
              ),
            ])));
  }
}
