import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

class DataUtils {
  static SharedPreferences sp;
  static Future initStorage() async {
    
    sp = await SharedPreferences.getInstance();
  }
}