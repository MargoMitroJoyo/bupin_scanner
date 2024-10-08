import 'dart:typed_data';

import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/camera/camera_provider.dart';
import 'package:Bupin/models/recent_soal.dart';
import 'package:Bupin/models/soal.dart';
import 'package:Bupin/navigation/navigation_provider.dart';
import 'package:Bupin/quiz/pdf_soal.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';

class HalamanPDFSoalState extends StatefulWidget {
  final Quiz quiz;
  final RecentSoal recentSoal;
  final List<WiidgetOption> listOption;
  final int skor;
  final String judul;
  const HalamanPDFSoalState(this.quiz, this.listOption, this.skor, this.judul,this.recentSoal);

  @override
  State<HalamanPDFSoalState> createState() => _HalamanPDFSoalStateState();
}

class _HalamanPDFSoalStateState extends State<HalamanPDFSoalState> {
  void _showPrintedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document printed successfully'),
      ),
    );
  }

  void _showSharedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document shared successfully'),
      ),
    );
  }

  List optionsLetters = ["A.", "B.", "C.", "D.", "E."];
  @override
  void initState() {
    super.initState();
  }

  recentSoalG() {
    if (Provider.of<NavigationProvider>(context, listen: false)
            .selectedRecentSoal ==
        null) {
      Provider.of<NavigationProvider>(context, listen: false).addRecentSoal(
          RecentSoal(namaBab:  widget.recentSoal.namaBab,namaMapel:  widget.recentSoal.namaMapel,link:  widget.recentSoal.link,
           ));
    } else {
      // Provider.of<NavigationProvider>(context, listen: false)
      //     .updateRecentSoal(RecentSoal(
      //   widget.recentSoal.namaBab,
      //   widget.recentSoal.namaMapel,
      //   widget.link,
      //   Helper.localAsset(widget.recentSoal.namaMapel),
      // ));
    }
    Provider.of<NavigationProvider>(context, listen: false)
        .selectingRecentSoal = null;
  }

  Uint8List? asu;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Provider.of<CameraProvider>(context, listen: false).scaning = false;
recentSoalG();
          Navigator.of(context).pop();
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.judul,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            leading: Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                  onTap: () {
recentSoalG();

                    Navigator.pop(context, false);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: Theme.of(context).primaryColor,
                        size: 15,
                        weight: 100,
                      ),
                    ),
                  )),
            ),
            actions: [
              IconButton(
                  onPressed: () async {
                    await Printing.sharePdf(
                        bytes: asu!, filename: widget.judul + ".pdf");
                  },
                  icon: Icon(
                    Icons.share,
                    color: Colors.white,
                  ))
            ],
          ),
          backgroundColor: Colors.white,
          body: PdfPreview(
            loadingWidget: const Text('Loading...'),
            // onError: (context, error) => const Text('Error...'),
            maxPageWidth: MediaQuery.of(context).size.width,
            pdfFileName: 'Laporan_Bulanan.pdf',
            canDebug: false, allowPrinting: false, actions: [],
            allowSharing: false,
            build: (format) async {
              asu = await printAll(
                 widget.quiz, widget.listOption, widget.skor);
              return printAll(
                 widget.quiz, widget.listOption, widget.skor);
            },
            onPrinted: _showPrintedToast,
            canChangeOrientation: false,
            canChangePageFormat: false,
            onShared: _showSharedToast,
          ),
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
