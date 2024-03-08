import 'dart:developer';

import 'package:Bupin/Halaman_Camera.dart';
import 'package:Bupin/styles/PageTransitionTheme.dart';
import 'package:Bupin/widgets/scann_aniamtion/scanning_effect.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HalmanScan extends StatefulWidget {
  const HalmanScan({super.key});

  @override
  State<HalmanScan> createState() => _HalmanScanState();
}

class _HalmanScanState extends State<HalmanScan> {
  @override
  void didChangeDependencies() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 223, 247, 218), // status bar color
    ));
    super.didChangeDependencies();
  }

  double width = 0;
  @override
  Widget build(BuildContext context) {
    log("scan");
    width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Stack(alignment: Alignment.center, children: [
          Container(
            color: Color.fromARGB(255, 223, 247, 218),
            alignment: Alignment.center,
          ),
          Positioned(
              top: 0,
              child: Image.asset(
                "asset/Halaman_Scan/Doodle Halaman Scan@4x.png",
                width: width,
              )),
          Positioned(
              bottom: 0,
              child: Image.asset(
                  "asset/Halaman_Scan/Cahaya Halaman Scan@4x.png",
                  width: width)),
          Positioned(
              bottom: 0,
              child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.asset("asset/Halaman_Scan/Manusia.png", width: width),
                    Image.asset("asset/Halaman_Scan/gradasi.png", width: width),
                    Positioned(
                        top: 0,
                        child: Image.asset(
                          "asset/Halaman_Scan/Logo Bupin@4x.png",
                          width: width * 0.35,
                        )),
                  ]))
        ]),
        backgroundColor: Color.fromARGB(255, 223, 247, 218),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: Stack(alignment: Alignment.center, children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(CustomRoute(
                builder: (context) => const QRViewExample(false),
              ));
            },
            child: Container(width:width * 0.2 ,height: width * 0.2,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 20,
                      offset: const Offset(0.5, 0.5),
                    ),
                  ],
                ),
                child:  Icon(
                  Icons.qr_code_scanner_rounded,
                  color: Colors.white,
                  size: width * 0.15 ,
                )),
          ),
          SizedBox(
            width: width * 0.3,
            height: width * 0.3,
            child: const ScanningEffect(
              enableBorder: false,
              scanningColor: Color.fromRGBO(236, 180, 84, 1),
              delay: Duration(milliseconds: 200),
              duration: Duration(seconds: 2),
              child: SizedBox(),
            ),
          ),
        ]),
      ),
    );
  }
}
