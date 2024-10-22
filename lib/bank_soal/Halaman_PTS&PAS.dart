import 'dart:math';

import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/bank_soal/mapel_provider.dart';
import 'package:Bupin/bank_soal/pts&pas.dart';

import 'package:Bupin/models/Video.dart';
import 'package:Bupin/models/soal.dart';
import 'package:Bupin/navigation/views/tabar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';

class HalamanMapel extends StatefulWidget {
  final Color color;
  final String judul;
  final String image;
  HalamanMapel({required this.color, required this.judul, required this.image});

  @override
  State<HalamanMapel> createState() => _HalamanMapelState();
}

class _HalamanMapelState extends State<HalamanMapel>
    with AutomaticKeepAliveClientMixin {
      
  initState() {
    Provider.of<MapelProvider>(context, listen: false).getListMapelPTS();
    Provider.of<MapelProvider>(context, listen: false).getListMapelPAS();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.width * 0.3),
          child: AppBar(
            backgroundColor: widget.color,
            automaticallyImplyLeading: false, // hides leading widget
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SafeArea(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    widget.judul,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "Kelas 12",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              titlePadding: EdgeInsets.only(right: 50, bottom: 20, left: 20),
              background: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      SizedBox(),
                      Positioned(
                        bottom: -2,
                        child: Image.asset(
                          "asset/Icon/Wave 1.png",
                          width: MediaQuery.of(context).size.width * 0.5,
                          color: Colors.white.withOpacity(0.05),
                        ),
                      ),
                      Image.asset(
                        "asset/Icon/Wave 2.png",
                        width: MediaQuery.of(context).size.width * 0.6,
                        color: Colors.white.withOpacity(0.1),
                      ),
                      Hero(
                          tag: widget.judul,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SafeArea(
                              child: Image.asset(
                                widget.image,
                                width: MediaQuery.of(context).size.width * 0.3,
                              ),
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        body: PtsPas(widget.color));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
