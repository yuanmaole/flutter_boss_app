import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_boss_app/application.dart';

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
        Future.delayed(Duration(milliseconds: 500), () {
          goPage();
        });
      }
    });
  }

  void goPage() async{

    await Application.init();
    // UserStore userModel = Provider.of<UserStore>(context);
    // userModel.initUser();
    // if (userModel.user != null) {
    //   await NetUtils.refreshLogin(context).then((value){
    //     if(value.data != -1){
    //       NavigatorUtil.goHomePage(context);
    //     }
    //   });
    //   Provider.of<PlayListModel>(context).user = userModel.user;
    // } else
    //   NavigatorUtil.goLoginPage(context);
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
            child: Image.asset('assets/images/LaunchImage.png'),
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
