import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_boss_app/application.dart';
import 'package:flutter_boss_app/model/model.dart';
import 'package:flutter_boss_app/utils/utils.dart';
import 'package:flutter_boss_app/service/service.dart';

class UserStore with ChangeNotifier {
  User _user;

  User get user => _user;

  /// 初始化 User
  void initUser() {
    // if (Application.storage.containsKey('user')) {
    //   String s = Application.storage.getString('user');
    //   _user = User.fromJson(json.decode(s));
    // }
  }

  /// 登录
  Future<User> login(BuildContext context, String phone, String pwd) async {

    var res = await UserService.login(context,phone, 'qwe123');
    User user =User.fromJson(res.data);
    if (user.code > 299) {
      LogUtil.showToast(user.msg ?? '登录失败，请检查账号密码');
      return null;
    }
    LogUtil.showToast(user.msg ?? '登录成功');
    _saveUserInfo(user);
    return user;
  }

  /// 保存用户信息到 sp
  _saveUserInfo(User user) {
    // _user = user;
    // Application.sp.setString('user', json.encode(user.toJson()));
  }
}
