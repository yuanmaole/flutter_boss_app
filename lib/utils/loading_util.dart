import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screen_util.dart';
class LoadingUtil {
  static bool isLoading = false;

  static void showLoading(BuildContext context) {
    if (!isLoading) {
      isLoading = true;
      showGeneralDialog(
          context: context,
          barrierDismissible: false,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          transitionDuration: const Duration(milliseconds: 150),
          pageBuilder: (BuildContext context, Animation animation,
              Animation secondaryAnimation) {
            return Align(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: setWidth(100),
                  height: setWidth(100),
                  color:  Color.fromRGBO(0, 0, 0, 0.4),
                  child: CupertinoActivityIndicator(
                    radius: setWidth(20),
                  ),
                ),
              ),
            );
          }).then((v) {
        isLoading = false;
      });
    }
  }

  static void hideLoading(BuildContext context) {
    if (isLoading) {
      Navigator.of(context).pop();
    }
  }
}
