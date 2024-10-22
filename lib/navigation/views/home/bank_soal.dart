import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/helper/helper.dart';
import 'package:Bupin/navigation/views/home/custtom.dart';
import 'package:flutter/material.dart';

import '../../../bank_soal/mapel_provider.dart';
import 'package:provider/provider.dart';

class BankSoal extends StatefulWidget {
  const BankSoal({super.key});

  @override
  State<BankSoal> createState() => _BankSoalState();
}

class _BankSoalState extends State<BankSoal> {
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
          child: Container(
              padding: EdgeInsets.all(15),
              child: Consumer<MapelProvider>(builder: (context, snapshot, c) {
                return Column(
                  children: [
                    Container(margin: EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          Text("Bank Soal",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Theme.of(context).primaryColor),),
                          Spacer(),
                          Container(
                            height:
                                MediaQuery.of(context).size.width * 0.19 * 9 / 16,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButton<String>(
                              padding: EdgeInsets.zero,
                              value: dropdownValue,
                              dropdownColor: Colors.white,
                              iconEnabledColor:
                                  const Color.fromARGB(255, 66, 66, 66),
                              icon: const Padding(
                                padding: EdgeInsets.only(left: 0),
                                child: Icon(
                                  Icons.arrow_drop_down_rounded,
                                  size: 20,
                                  color: Color.fromARGB(255, 81, 87, 97),
                                  weight: 10,
                                ),
                              ),
                              elevation: 16,
                              style: const TextStyle(
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w700,
                                color: Color.fromARGB(255, 81, 87, 97),
                              ),
                              underline: Container(
                                height: 0,
                                color: Colors.transparent,
                              ),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                      
                                dropdownValue = value!;
                                Provider.of<MapelProvider>(context, listen: false)
                                    .getRecentMapel(dropdownValue);
                                setState(() {});
                                // fetchApi();
                              },
                              items: list
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Wrap(
                      spacing: 20,
                      runSpacing: 15,
                      children: snapshot.listMapel
                          .map(
                            (e) => CustomButton2(
                                Helper.addSpaceAfterCapitalized(e)),
                          )
                          .toList(),
                    ),
                  ],
                );
              }))),
    );
  }
}
