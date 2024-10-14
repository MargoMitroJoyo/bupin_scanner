import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/bank_soal/Halaman_PTS&PAS.dart';
import 'package:Bupin/helper/helper.dart';
import 'package:Bupin/styles/PageTransitionTheme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String subject;
  const CustomButton(this.subject);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  static const double _shadowHeight = 4;
  double _position = 4;

  String dropdownValue = list.first;

  List<String> subjects = [
    'Bahasa Indonesia',
    'Bahasa Inggris',
    'Bahasa Jawa',
    'Bahasa Jawa Timur',
    'Bahasa Sunda',
    'Biologi',
    'Fisika',
    'Kimia',
    // 'IPA',
    // 'IPAS',
    'Informatika',
    'Matematika',
    // 'Matematika Peminatan',
    // 'IPS',
    'Geografi',
    'Ekonomi',
    'Antropologi',
    'Sosiologi',
    'Sejarah',
    // 'Sejarah Indonesia',
    // 'Seni Budaya',
    'Seni Musik',
    'Seni Rupa',
    'Penjas',
    //  'Prakarya',
    'Pendidikan Pancasila',
    // 'PKWU',

    // 'BK',
    'Bahasa Arab',
    // 'BTQ',
    // 'Akidah Akhlak',
    // 'Fikih',
    // 'PAIBP',
    // 'Qurdis',
    // 'SKI',
  ];
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
          height: _height + _shadowHeight,
          width: MediaQuery.of(context).size.width * 0.45,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  height: _height,
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                    color: Helper.localColor(widget.subject),
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                ),
              ),
              SizedBox(), AnimatedPositioned(
                curve: Curves.easeIn,
                bottom: _position,
                duration: Duration(milliseconds: 70),
                child: Container(
                  height: _height,
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                    color: lightenColor(Helper.localColor(widget.subject)),
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
                  top: -30,
                  right: -15,
                  bottom: _position,
                  duration: Duration(milliseconds: 70),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Hero(
                        tag: Helper.localAsset(widget.subject),
                        child: Container(
                          child: Image.asset(
                            Helper.localAsset(widget.subject),
                            height: MediaQuery.of(context).size.width * 0.14,
                            width: MediaQuery.of(context).size.width * 0.14,
                          ),
                        ),
                      ),
                    ),
                  )),AnimatedPositioned(
                curve: Curves.easeIn,
                bottom: _position,
                duration: Duration(milliseconds: 70),
                child: Container(
                  height: _height,
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                    color:Colors.transparent,
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
              ..color =  lightenColor(Helper.localColor(widget.subject)),
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
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                    color:Colors.transparent,
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