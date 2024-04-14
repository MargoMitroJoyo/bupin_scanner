import 'dart:developer';
import 'dart:io';

import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/widgets/scann_aniamtion/scanning_effect.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  final bool scanned;
  const QRViewExample(this.scanned, {super.key});

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  late bool scanned;
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  void _onQRViewCreated(QRViewController controller) async {
    setState(() {
      this.controller = controller;
    });
    controller.resumeCamera();
    controller.scannedDataStream.listen((scanData) async {
      try {
        if (scanned == false) {
          if (scanData.code!.contains("VID")) {
            setState(() {});
            scanned = true;

            scanned = await ApiService().scanQrVideo(scanData.code!, context);
            setState(() {});
          } else if (scanData.code!.contains("UJN")) {
            setState(() {});
            scanned = true;

            scanned = await ApiService().scanQrCbt(scanData.code!, context);
            setState(() {});
          }
        }
      } catch (e) {}
    });
  }

  @override
  void didChangeDependencies() {
    scanned = widget.scanned;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
              flex: 3,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _buildQrView(context),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.7,
                    height: MediaQuery.of(context).size.width / 1.7,
                    child: const ScanningEffect(
                      enableBorder: false,
                      scanningColor: Color.fromRGBO(236, 180, 84, 1),
                      delay: Duration(seconds: 1),
                      duration: Duration(seconds: 2),
                      child: SizedBox(),
                    ),
                  ),
                ],
              )),
          Expanded(
              flex: 2,
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                 
                        Image.asset(
                          "asset/doodle camera.png",
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitWidth,
                          repeat: ImageRepeat.repeat,
                        ),
                        Positioned(top: 1,left: 1,
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton.filled(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white)),
                                color: Colors.white,
                                highlightColor: Colors.grey,
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                icon: Icon(
                                  Icons.arrow_back_rounded,
                                  color: Theme.of(context).primaryColor,
                                )),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: -55,
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Image.asset(
                                "asset/Halaman_Scan/Hasan Scan2.png",
                                scale: 1,
                              )),
                        ),
                        Positioned(
                          left: 10,
                          top: 120,
                          child: Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "Scan",
                              style: TextStyle(
                                fontSize: 40,
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.w900,
                                shadows: <Shadow>[
                                  Shadow(
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 15,
                                      color:
                                          Color.fromARGB(255, 112, 182, 134)),
                                  Shadow(
                                    offset: Offset(1, 1),
                                    blurRadius: 5.0,
                                    color: Color.fromARGB(122, 236, 236, 236),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            left: 10,
                            top: 160,
                            child: Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                "Akses Video & Soal",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Color.fromRGBO(236, 180, 84, 1),
                                  fontWeight: FontWeight.w700,
                                  shadows: <Shadow>[
                                    Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 15,
                                        color:
                                            Color.fromARGB(255, 112, 182, 134)),
                                    Shadow(
                                      offset: Offset(1, 1),
                                      blurRadius: 5.0,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                     
                  
                  Positioned(
                      top: 0,
                      child: Image.asset(
                        "asset/Halaman_Scan/Logo Bupin@4x.png",
                        width: MediaQuery.of(context).size.width * 0.25,
                      )),
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.height < 400)
        ? MediaQuery.of(context).size.width / 2
        : MediaQuery.of(context).size.width / 2;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: const Color.fromRGBO(0, 140, 64, 1),
          borderRadius: 6,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();

    super.dispose();
  }
}
