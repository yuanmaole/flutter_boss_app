import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boss_app/router/custom_router.dart';
import 'package:flutter_boss_app/pages/home.dart';
import 'package:flutter_boss_app/pages/login.dart';

// import 'package:flutter_boss_app/pages/result/notfound_page.dart';
// import 'package:flutter_boss_app/pages/result/search.dart';
// import 'package:flutter_boss_app/pages/chat/chat_message.dart';
class NavigatorUtils {
  static double screenWidth;
  static double screenHeight;
  static double statusBarHeight;
  static double bottomBarHeight;

  // 定义无参数导航
  final GlobalKey<NavigatorState> key = GlobalKey(debugLabel: 'navigate_key');
  final Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
    "/home": (BuildContext context) => HomePage(),
    '/login':(BuildContext context) => LoginPage()
    
  };
  NavigatorState get navigator => key.currentState;
  get pushNamed => navigator.pushNamed;
  get popAndPushNamed => navigator.popAndPushNamed;

  static pushName(BuildContext context,String routeName){
    return Navigator.of(context).pushNamed(routeName);
  }
  //定义有参数导航
//   static gotoSearchGoodsPage(BuildContext context, {String keywords}) {
// //    NavigatorRouter(
// //        context,
// //        new SearchGoodsPage(
// //          keywords: keywords,
// //        ));

//     return Navigator.of(context).push(new MyCupertinoPageRoute(SearchGoodsPage(
//       keywords: keywords,
//     )));
//   }

  // static gotoSearchGoodsResultPage(BuildContext context, String keywords) {
  //   NavigatorRouter(
  //       context,
  //       new SearchGoodsResultPage(
  //         keywords: keywords,
  //       ));
  // }

  static NavigatorRouter(BuildContext context, Widget widget) {
    return Navigator.push(context, new CupertinoPageRoute(builder: (context) => widget));
  }

  ///弹出 dialog
  static Future<T> showGSYDialog<T>({
    @required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder builder,
  }) {
    return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return MediaQuery(
            ///不受系统字体缩放影响
              data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .copyWith(textScaleFactor: 1),
              child: new SafeArea(child: builder(context)));
        });
  }
}

class MyCupertinoPageRoute extends CupertinoPageRoute {
  Widget widget;

  MyCupertinoPageRoute(this.widget) : super(builder: (BuildContext context) => widget);

  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: widget);
  }

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => Duration(seconds: 0);
}
