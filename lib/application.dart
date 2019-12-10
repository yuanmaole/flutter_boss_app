import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boss_app/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Application{
  static Router router;
  static GlobalKey<NavigatorState> key = GlobalKey();
  static SharedPreferences storage;

  static double screenWidth;
  static double screenHeight;
  static double statusBarHeight;

  static init() async{
    await DataUtils.initStorage();
    
  }

}