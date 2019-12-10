import 'dart:convert';
import 'package:dio/dio.dart';

class Resp<T>{
  T data;
  int code;
  String msg;

  Resp({
    this.data,
    this.code,
    this.msg
  });

  Resp.fromRes(Response res) {
    data = res.data;
    code = res.statusCode;
    msg = res.statusMessage;
  }
  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}