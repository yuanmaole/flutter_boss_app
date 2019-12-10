import 'package:flutter/material.dart';
import 'package:flutter_boss_app/pages/splash_page.dart';
import 'package:flutter_boss_app/provider/account_store.dart';
import 'package:provider/provider.dart';
import 'application.dart';
import 'utils/utils.dart';

void main() {
  Application.init();
  LogUtil.init(tag: 'NETEASE_MUSIC');
//  AudioPlayer.logEnabled = true;
  Provider.debugCheckInvalidValueType = null;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserStore>.value(
        value: UserStore(),
      )
    ],
    child: MyApp(),
  ));
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          splashColor: Colors.transparent,
          tooltipTheme: TooltipThemeData(verticalOffset: -100000)),
      home: SplashPage()
    );
  }
}
