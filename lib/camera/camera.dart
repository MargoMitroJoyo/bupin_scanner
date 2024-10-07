import 'dart:developer';
import 'dart:io';

import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/camera/camera_provider.dart';
import 'package:Bupin/camera/scann_aniamtion/scanning_effect.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
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

  @override
  void dispose() {
    controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.height < 400)
        ? MediaQuery.of(context).size.width / 2
        : MediaQuery.of(context).size.width / 2;
    return Consumer<CameraProvider>(builder: (context, data, x) {
      log("consumer");
      if (controller != null && data.scanned==false ) {
        controller!.resumeCamera();
      }

      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
                flex: 4,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    QRView(
                      key: qrKey,
                      onQRViewCreated: (controller2) {
                        controller = controller2;
                        controller2!.scannedDataStream.listen(
                          (scanData) async {
                            log(scanData.code.toString());
                            if (data.scanned == false) {
                              if (scanData.code!.contains("VID")) {
                                controller2.pauseCamera();

                                data.scaning = true;

                                ApiService()
                                    .pushToVideo(scanData.code!, context);
                              } else if (scanData.code!.contains("UJN")) {
                                controller2.pauseCamera();

                                data.scaning = true;

                                ApiService().pushToCbt(scanData.code!, context);
                              }
                            }
                          },
                        );
                      },
                      overlay: QrScannerOverlayShape(
                          borderColor: Color.fromARGB(255, 164, 3, 3),
                          borderRadius: 6,
                          borderLength: 30,
                          borderWidth: 10,
                          cutOutSize: scanArea),
                      onPermissionSet: (ctrl, p) =>
                          _onPermissionSet(context, ctrl, p),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.7,
                      height: MediaQuery.of(context).size.width / 1.7,
                      child: const ScanningEffect(
                        enableBorder: false,
                        scanningColor: Colors.white,
                        delay: Duration(seconds: 1),
                        duration: Duration(seconds: 2),
                        child: SizedBox(),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      );
    });
  }
}

final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
  log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
  if (!p) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('no Permission')),
    );
  }
}
