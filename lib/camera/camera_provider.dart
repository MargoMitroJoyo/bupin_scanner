import 'dart:convert';
import 'dart:developer';

import 'package:Bupin/models/recent_soal.dart';
import 'package:Bupin/models/recent_video.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CameraProvider extends ChangeNotifier {
bool scanned=false;

set scaning(val){
  scanned=val;
  log("notify");
  notifyListeners();
}
}

 
  // saveRecentSoal() {}
  // getRecentSoal() {}