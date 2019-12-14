import 'package:flutter/material.dart';
import 'package:flutter_boss_app/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/utils.dart';
import 'service/session.dart';
class Application{
  static Widget initPage;
  static SharedPreferences storage;
  static final String spIsLogin = "isLogin";
  static final String spPhone = "phone";
  static final String spPassword = "password";

  static final String spUser = "user";
  static final String spTicket = "ticket";
  static Future init() async{
    storage = await SharedPreferences.getInstance();
    Session.init(); 
  }

  //暂时放在本地
  static Future setAccount(String phone ,String password) async {
    var _password = await EncryptUtil.encode(password);
    await storage?.setString("phone",phone);
    await storage?.setString("password",_password);
  }
  static getsetAccount (){
    // var phone = storage?.getString("phone")?? null;
    // var password =
  }
}