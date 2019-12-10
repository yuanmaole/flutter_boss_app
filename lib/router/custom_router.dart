import 'package:flutter/material.dart';
class BottomPopupRouter extends PageRouteBuilder{
  final Widget widget;
  BottomPopupRouter(this.widget)
  :super(
    transitionDuration: Duration(milliseconds: 500),
    pageBuilder: ( BuildContext context, Animation<double> animation1, Animation<double> animation2 ){
      return widget;
    },
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation1,
      Animation<double> animation2 ,
      Widget child ){
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end:  const Offset(0, 0),
        ).animate(CurvedAnimation(
          parent: animation1,
          curve: Curves.linear
        )),
        child: child,
      );
    }
  );
}