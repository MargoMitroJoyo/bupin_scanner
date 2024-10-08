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
    return InkWell(
      onTap: () {
        Provider.of<NavigationProvider>(context, listen: false)
            .selectedRecentSoal = soal;
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HalamanSoal(link: soal.link),
        ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        height: MediaQuery.of(context).size.width * 0.2,
        child: Container(
                     padding: EdgeInsets.all(2),

          decoration: BoxDecoration(
              border: Border.all(
                  width: 2,
                  color: Helper.localColor(soal.namaMapel!).withOpacity(0.2)),
              borderRadius: BorderRadius.circular(15),
              color: Colors.white),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
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
                                      color: Helper.localColor(soal.namaMapel!),
                                    )),
                                Opacity(
                                    opacity: 0.3,
                                    child: Image.asset("asset/Icon/Bg t.png")),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    Helper.localAsset(soal.namaMapel!),
                                    width: 50,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ))),
              ),
              Flexible(flex: 15,
                child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                            child: Text(
                              soal.namaBab!, softWrap: false,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Text(
                          soal.namaMapel!.toTitleCase(),
                          maxLines: 2,
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    )),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Helper.localColor(soal.namaMapel!),
                  size: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
