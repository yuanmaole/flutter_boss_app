import 'dart:async';
import 'dart:io';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:flutter_boss_app/providers/index.dart';
class Session {
  static final Dio dio = Dio();
  static final Dio tokenDio = Dio();
  static final DefaultCookieJar cookieJar = DefaultCookieJar();
  static final CookieManager cookieManager = CookieManager(cookieJar);
  static final DefaultCookieJar tokenCookieJar = DefaultCookieJar();
  static final CookieManager tokenCookieManager = CookieManager(tokenCookieJar);
  static final baseUrl = "http://httpbin.org/";
  static String _authorization = "";

  static setToken(String authorization){
    _authorization = authorization;
  }

  static init(){
    dio.options
      ..baseUrl = baseUrl
      ..connectTimeout = 5000 //5s
      ..receiveTimeout = 5000
      ..validateStatus = (int status) {
        return status > 0;
      }
      // ..interceptors.add(CookieManager(cj))
      ..headers = {
        HttpHeaders.userAgentHeader: 'dio',
        "authorization":_authorization,
        'common-header': 'xx',

      };
    // dio.interceptors.add(HttpInterceptor());

  }
  
  

  static Future<Response> get(String url,Object data) async {
    return dio.get( url, queryParameters: data);
  }
  static Future<Response> post(String url, {data}) async {
    return dio.post( url, data: data);
  }
  static Future<Response> put(String url, {data}) async {
    return dio.put( url, data: data);
  }
  static Future<Response> de(String url, {data}) async {
    return dio.delete( url, data: data);
  }
}
class HttpInterceptor extends Interceptor {
  var _cache = Map<Uri, Response>();

  @override
  Future onRequest(RequestOptions options) async {
    Response response = _cache[options.uri];
    if (options.extra["refresh"] == true) {
      print("${options.uri}: force refresh, ignore cache! \n");
      return options;
    } else if (response != null) {
      print("cache hit: ${options.uri} \n");
      return response;
    }
  }

  @override
  Future onResponse(Response response) async {
    // if (response.statusCode >= 300 && response.statusCode < 400) {
      
    //   return Future.error(Response(data: -1));
    // } else {
    //   return Future.value(e.response);
        // }
    _cache[response.request.uri] = response;
  }

  @override
  Future onError(DioError e) async {
    print('onError: $e');
  }
}