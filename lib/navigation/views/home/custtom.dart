import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/bank_soal/Halaman_PTS&PAS.dart';
import 'package:Bupin/bank_soal/mapel_provider.dart';
import 'package:Bupin/helper/helper.dart';
import 'package:Bupin/styles/PageTransitionTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomButton2 extends StatefulWidget {
  final String subject;
  const CustomButton2(this.subject);

  @override
  State<CustomButton2> createState() => _CustomButton2State();
}

class _CustomButton2State extends State<CustomButton2> {
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
    // final double _height = 64 - _shadowHeight;
    return Container(
      child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  Provider.of<MapelProvider>(context, listen: false)
                      .selectingMapel = widget.subject;
                  setState(() {
                    _position = 0;
                  });
                  await Future.delayed(Duration(milliseconds: 70));
                  setState(() {
                    _position = 4;
                  });
                  await Future.delayed(Duration(milliseconds: 70));
                  Navigator.of(context).push(CustomRoute(
                    builder: (context) => HalamanMapel(
                        color: Helper.localColor(widget.subject),
                        judul: widget.subject,
                        image: Helper.localAsset(widget.subject)),
                  ));
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
                  height: MediaQuery.of(context).size.width * 0.16 + _shadowHeight,
                  width: MediaQuery.of(context).size.width * 0.16,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.16,
                          width: MediaQuery.of(context).size.width * 0.16,
                          decoration: BoxDecoration(
                            color: Helper.localColor(widget.subject),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(),
                      AnimatedPositioned(
                        curve: Curves.easeIn,
                        bottom: _position,
                        duration: Duration(milliseconds: 70),
                        child: Container(
                          height:  MediaQuery.of(context).size.width * 0.16,child:Hero(
                                tag: widget.subject,
                                child: Container(padding: EdgeInsets.all(10),
                                  child: Image.asset(
                                    Helper.localAsset(widget.subject),
                                    height: MediaQuery.of(context).size.width * 0.1,
                                    width: MediaQuery.of(context).size.width * 0.1,
                                  ),
                                ),
                              ) ,
                          width: MediaQuery.of(context).size.width * 0.16,
                          decoration: BoxDecoration(
                            color: lightenColor(Helper.localColor(widget.subject)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                   
                    ],
                  ),
                ),
              ),
              Container(margin: EdgeInsets.only(top: 2),
                width: MediaQuery.of(context).size.width * 0.16,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Text(
                  widget.subject,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          
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