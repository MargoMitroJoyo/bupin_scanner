import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  const Empty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
                            child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "asset/notfound.png",
                                  height: 100,
                                  alignment: Alignment.center,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "History Empty",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.grey),
                                    ),
                                    Text(
                                      "Silahkan Scan QR",
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.grey),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ));
  }
}