import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/bank_soal/Halaman_PTS&PAS.dart';
import 'package:Bupin/bank_soal/halaman_ujian.dart';
import 'package:Bupin/bank_soal/mapel_provider.dart';
import 'package:Bupin/helper/helper.dart';
import 'package:Bupin/quiz/Halaman_Soal.dart';
import 'package:Bupin/styles/PageTransitionTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PtsPasItem extends StatefulWidget {
  final String subject;
  final String idMapel;
  final Color color;
  final String ptspas;
  const PtsPasItem(this.subject, this.idMapel, this.color,this.ptspas);

  @override
  State<PtsPasItem> createState() => _PtsPasItemState();
}

class _PtsPasItemState extends State<PtsPasItem> {
  @override
  static const double _shadowHeight = 4;
  double _position = 4;

  String dropdownValue = list.first;

  Color lightenColor(Color color, [double amount = 0.15]) {
    // Use Color.lerp to mix the color with white
    return Color.lerp(color, Colors.white, amount)!;
  }

  @override
  Widget build(BuildContext context) {
    final double _height = 64 - _shadowHeight;
    return Center(
      child: GestureDetector(
        onTap: () async {
          setState(() {
            _position = 0;
          });
          await Future.delayed(Duration(milliseconds: 70));
          setState(() {
            _position = 4;
          });
          await Future.delayed(Duration(milliseconds: 70));
          var jenjang = Provider.of<MapelProvider>(context, listen: false)
              .selectedJenjang
              .toLowerCase();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Ujian(ptspas: widget.ptspas,namaBab:widget.subject ,
                
                  link:
                      "https://cbt.api.bupin.id/api/mapel/${widget.idMapel}?level=$jenjang&noscan=true")));
        },
        onTapUp: (_) {
          setState(() {
            _position = 4;
          });
        },
        onTapDown: (_) {
          setState(() {
            _position = 0;
          });
        },
        onTapCancel: () {
          setState(() {
            _position = 4;
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          height: _height + _shadowHeight,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  height: _height,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                ),
              ),
              SizedBox(),
              AnimatedPositioned(
                curve: Curves.easeIn,
                bottom: _position,
                duration: Duration(milliseconds: 70),
                child: Container(
                  height: _height,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: lightenColor(widget.color),
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.subject,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                curve: Curves.easeIn,
                bottom: _position,
                duration: Duration(milliseconds: 70),
                child: Container(
                  height: _height,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.subject,
                      style: TextStyle(
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 2
                          ..color = lightenColor(widget.color),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                curve: Curves.easeIn,
                bottom: _position,
                duration: Duration(milliseconds: 70),
                child: Container(
                  height: _height,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.subject,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// ShaderMask(
// shaderCallback: (rectangle) {
// return LinearGradient(stops: [5,1],
// colors: [Colors.black, Colors.transparent],
// begin: Alignment.topCenter,
// end: Alignment.bottomCenter
// ).createShader (Rect.fromLTRB(0, 0, rectangle.width, rectangle.height)); 
// },
// blendMode: BlendMode.dstIn,