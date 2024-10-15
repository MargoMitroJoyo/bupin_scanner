import 'package:flutter/material.dart';

class Mapel {
  final String idMapel;
  final String nama;



  Mapel(this.idMapel, this.nama, );
  factory Mapel.fromMap(Map<String, dynamic> data) {
  
    return Mapel(
      data["id_mapel"].toString(),
      data["nama"].toString(),
      
    );
  }
}
