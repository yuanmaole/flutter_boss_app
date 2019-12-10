import 'package:flutter/material.dart';
import 'session.dart';
import 'package:flutter_boss_app/model/model.dart';

class UserService{
  static Future<Resp> login(
      BuildContext context, String phone, String password) async {
    var response = await Session.get('/login/cellphone',{
      'phone': phone,
      'password': password,
    });
    return Resp.fromRes(response);
  }
}