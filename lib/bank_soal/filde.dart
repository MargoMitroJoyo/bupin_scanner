// @override
//   Widget build(BuildContext context) {
//     final double _height = 64 - _shadowHeight;
//     return GestureDetector(
//       onTap: () async {
//         setState(() {
//           _position = 0;
//         });
//         await Future.delayed(Duration(milliseconds: 110));
//         setState(() {
//           _position = 4;
//         });
//       },
//       // onTapUp: (_) {
//       //   setState(() {
//       //     _position = 4;
//       //   });
//       // },
//       onTapDown: (_) {
//         setState(() {
//           _position = 0;
//         });
//       },
//       // onTapCancel: () {
//       //   setState(() {
//       //     _position = 4;
//       //   });
//       // },
//       child: Container(
//         height: _height + _shadowHeight,
//         child: Stack(
//           children: [
//             SizedBox(),
//             Positioned(
//               bottom: 0,
//               child: Container(
//                 height: _height,
//                 decoration: BoxDecoration(
//                   color: Helper.localColor(widget.subject),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(16),
//                   ),
//                 ),
//               ),
//             ),
//             AnimatedPositioned(
//                 curve: Curves.easeIn,
//                 bottom: _position,
//                 duration: Duration(milliseconds: 70),
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).push(CustomRoute(
//                       builder: (context) => HalamanMapel(
//                           color: Helper.localColor(widget.subject),
//                           judul: widget.subject,
//                           image: Helper.localAsset(widget.subject)),
//                     ));
//                   },
//                   child: Container(
//                     margin: EdgeInsets.symmetric(vertical: 5),
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     child: Stack(
//                       alignment: Alignment.center,
//                       clipBehavior: Clip.none,
//                       children: [
//                         Container(
//                           height: MediaQuery.of(context).size.width * 0.2,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15),
//                               color: Helper.localColor(widget.subject)
//                                   .withOpacity(0.8),
//                               border: Border(
//                                 bottom: BorderSide(
//                                     width: 3,
//                                     color: Helper.localColor(widget.subject)),
//                               )),
//                         ),
//                         Positioned(
//                             top: -25,
//                             right: -10,
//                             child: Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: Hero(
//                                 tag: Helper.localAsset(widget.subject),
//                                 child: Image.asset(
//                                   Helper.localAsset(widget.subject),
//                                   height:
//                                       MediaQuery.of(context).size.width * 0.14,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.14,
//                                 ),
//                               ),
//                             )),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             widget.subject,
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 15),
//                           ),
//                         ),
//                         // Opacity(
//                         //     opacity:
//                         //         0.3,
//                         //     child:
//                         //         Image.asset("asset/Icon/Bg t.png")),
//                       ],
//                     ),
//                   ),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }