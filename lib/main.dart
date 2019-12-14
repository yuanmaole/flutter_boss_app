import 'package:flutter/material.dart';
import 'package:flutter_boss_app/providers/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'application.dart';
import 'utils/utils.dart';
import 'pages/pages.dart';

void main() async{
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
      navigatorKey: NavigatorUtil.key,
      theme: ThemeData(
        brightness: Brightness.light,
        dialogBackgroundColor: Colors.teal[300],
        accentColor: Colors.teal[300],
        primaryColor: Colors.teal[300],
        splashColor: Colors.transparent,
        tooltipTheme: TooltipThemeData(verticalOffset: -100000)
      ),
      home: SplashPage(),
      routes: NavigatorUtil.routes,
      onUnknownRoute: (RouteSettings rs) => new MaterialPageRoute(
        builder: (context) => LoginPage()
      )
    );
  }
}