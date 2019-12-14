import 'package:flutter/material.dart';
import 'package:flutter_boss_app/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState()=>_HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }
  int last = 0;
  Future<bool> doubleBackExit() {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - last > 800) {
      LogUtil.showToast("再按一次退出应用");
      last = DateTime.now().millisecondsSinceEpoch;
      return Future.value(false);
    } else {
      LogUtil.cancelToast();
      return Future.value(true);
    }
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    return WillPopScope(
      onWillPop: doubleBackExit,
      child: Scaffold(
        backgroundColor:Colors.white ,
        body: SafeArea(
          child: Center(
            child: Text('第一页')
          ),)
          
        
      )
    );
  }
}