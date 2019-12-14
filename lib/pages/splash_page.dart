import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter_boss_app/providers/index.dart';
import 'package:flutter_boss_app/application.dart';
import 'package:flutter_boss_app/service/service.dart';
import 'package:flutter_boss_app/utils/utils.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController _logoController;
  Tween _scaleTween;
  CurvedAnimation _logoAnimation;

  @override
  void initState() {
    super.initState();

    _scaleTween = Tween(begin: 0, end: 1);
    _logoController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..drive(_scaleTween);
    Future.delayed(Duration(milliseconds: 500), () {
      _logoController.forward();
    });
    _logoAnimation =
        CurvedAnimation(parent: _logoController, curve: Curves.easeOutQuart);

    _logoController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 1000), () {
          goPage();
        });
      }
    });
  }

  void goPage() async{
    //初始化操作。。。
    LogUtil.init(tag: 'NETEASE_MUSIC');
    await Application.init();
    UserStore userStore = Provider.of<UserStore>(context);
    userStore.initUser();
    //返回拦截
    Session.dio.interceptors.add(InterceptorsWrapper(
    onResponse:(Response response) async {
      if (response.statusCode == 401) {
        userStore.clearUser();
      } else if (response.statusCode == 403) {
        print('签名验证失败');
      }
     return response; // continue
    }));
    //
    if (userStore.user != null) {
      //刷新用户信息
      //  await NetUtils.refreshLogin(context).then((value){
      //   if(value.data != -1){
      //     NavigatorUtil.goHomePage(context);
      //   }
      // });
      // Provider.of<PlayListModel>(context).user = userModel.user;
      NavigatorUtil.pushName(context, '/home');
    } else {
      NavigatorUtil.goLoginPage(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ScaleTransition(
          scale: _logoAnimation,
          child: Hero(
            tag: 'logo',
            child: Image.asset('assets/images/icon_logo.png')
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _logoController.dispose();
  }
}
