import 'package:Bupin/bank_soal/custom_button.dart';
import 'package:Bupin/bank_soal/mapel_provider.dart';
import 'package:Bupin/bank_soal/pts&pas_item.dart';
import 'package:Bupin/navigation/component/recent_video_item.dart';
import 'package:Bupin/navigation/component/recet_soal_item.dart';
import 'package:Bupin/navigation/navigation_provider.dart';
import 'package:Bupin/widgets/empty.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PtsPas extends StatelessWidget {
  final Color color;
  const PtsPas(this.color);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Consumer<NavigationProvider>(builder: (context, data, c) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: new Size(50.0, 50.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    color: Colors.white),
                child: TabBar(
                  indicatorColor: color,
                  onTap: (v) {
                    // if (v == 0) {
                    //   Provider.of<MapelProvider>(context, listen: false)
                    //       .getListMapelPTS();
                    // } else {
                    //   Provider.of<MapelProvider>(context, listen: false)
                    //       .getListMapelPAS();
                    // }
                  },
                  unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500,
                      fontFamily: "Nunito"),
                  tabs: [
                    Tab(
                      icon: Text(
                        "PTS",
                        style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.w900,
                            fontSize: 16),
                      ),
                    ),
                    Tab(
                        icon: Text(
                      "PAS",
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w900,
                          fontSize: 15),
                    )),
                  ],
                ),
              ),
            ),
            body: Container(
              color: Colors.white,
              child: Consumer<MapelProvider>(builder: (context, snapshot, C) {
                return TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    snapshot.listSelctedMapel.isEmpty
                        ? Empty()
                        : Column(
                            children: snapshot.listSelctedMapel
                                .map(
                                  (e) => PtsPasItem(e.nama,e.idMapel,color,"PTS"),
                                )
                                .toList(),
                          ),
                    snapshot.listSelctedMapelPas.isEmpty
                        ? Empty()
                        : Column(
                            children: snapshot.listSelctedMapelPas
                                .map(
                                  (e) => PtsPasItem(e.nama,e.idMapel,color,"PTS"),
                                )
                                .toList(),
                          )
                  ],
                );
              }),
            ),
          );
        }));
  }
}
