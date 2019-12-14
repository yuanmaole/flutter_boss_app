import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LogUtil {
  static const String _TAG_DEF = "###common_utils###";

  static bool debuggable = false; //是否是debug模式,true: log v 不输出.
  static String TAG = _TAG_DEF;

  //Toast
  static void showToast(String msg) {
        // debugPrint(msg);
    Fluttertoast.showToast(msg: msg, gravity: ToastGravity.CENTER);

  }
  static void showToastCenter(String msg) {
    Fluttertoast.showToast(msg: msg, gravity: ToastGravity.BOTTOM);

  }
  static void cancelToast() {
    Fluttertoast.cancel();
  }

  static void init({bool isDebug = false, String tag = _TAG_DEF}) {
    debuggable = isDebug;
    TAG = tag;
  }
  
  static void e(Object object, {String tag}) {
    _printLog(tag, '：', object);
  }

  static void v(Object object, {String tag}) {
    if (debuggable) {
      _printLog(tag, '：', object);
    }
  }

  static void _printLog(String tag, String stag, Object object) {
    String da = object.toString();
    String _tag = (tag == null || tag.isEmpty) ? TAG : tag;
    while (da.isNotEmpty) {
      if (da.length > 1024) {
        print("$_tag $stag ${da.substring(0, 1024)}");
        da = da.substring(1024, da.length);
      } else {
        print("$_tag $stag $da");
        da = "";
      }
    }
  }
}