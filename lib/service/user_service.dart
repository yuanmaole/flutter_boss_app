import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'session.dart';
import 'package:flutter_boss_app/model/model.dart';
import 'package:flutter_boss_app/utils/utils.dart';

class UserService {
  static Future<Response> sendRequest( BuildContext context) {
    return  Future.delayed(new Duration(seconds: 2), () {
        return Response(data: {},statusCode: 200,statusMessage: "操作成功");
      });  
  }
  static Future<Response> login(
      BuildContext context, String phone, String password) {
    // return Session.get('/login/cellphone',{ 'phone': phone, 'password': password});
    return  Future.delayed(new Duration(seconds: 2), () {
        return Response(data: {
           "id":"3f3ff5d5-d7df-4f68-ad5d-312b8344541d",
      "token":"3f3ff5d5-d7df-4f68-ad5d-312b8344541d",
      "createTime":1576217548
        },statusCode: 200,statusMessage: "操作成功");
      }); 
  }
  static Future<Response> refreshLogin(
      BuildContext context, String phone, String password) {
    return Session.get('/login/cellphone',{ 'phone': phone, 'password': password});
  }
}