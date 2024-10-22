import 'package:Bupin/helper/helper.dart';
import 'package:flutter/material.dart';

class HeaderCard extends StatelessWidget {
  const HeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [
          0.5,
          0.3,
        ],
        colors: [
          Theme.of(context).primaryColor,
          Color.fromRGBO(243, 247, 250, 1),
        ],
      )),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Total Scan",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Ranking",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color:
                      Helper.darkenColor(Theme.of(context).primaryColor, 0.4),
                  borderRadius: BorderRadius.circular(5)),
              height: MediaQuery.of(context).size.width * 0.25,
            )
          ],
        ),
        height: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
            color: Helper.darkenColor(Theme.of(context).primaryColor, 0.2),
            borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
