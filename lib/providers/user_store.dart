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
      Application.storage?.remove("user");

    if (Application.storage.containsKey('user')) {
      String s = Application.storage.getString('user');
      _user = User.fromJson(json.decode(s));
    }
  }

  /// 登录
  Future<bool> loginWithPhone(BuildContext context, String phone, String code) async {
    try {
      LoadingUtil.showLoading(context);
      var res = await UserService.login(context,phone,code);
      if(res.statusCode==200){
        User newUser =User(phone: phone,loginType: 1,account: Account.fromJson(res.data));
        _saveUserInfo(newUser);
        LogUtil.showToast('登录成功！');
        return true;
      }else{
        LogUtil.showToast('登录失败！');
        return false;

      }
    } catch (e) {
      print(e);
      return false;
    } finally {
      LoadingUtil.hideLoading(context);
    }

  }
  Future<bool> loginWithPassword(BuildContext context, String phone, String pwd) async {
     try {
      LoadingUtil.showLoading(context);
      var res = await UserService.login(context,phone,pwd);
      if(res.statusCode==200){
        User newUser =User(phone: phone,loginType: 1,account: Account.fromJson(res.data));
        _saveUserInfo(newUser);
        LogUtil.showToast('登录成功！');
        return true;
      }else{
        LogUtil.showToast('登录失败！');
        return false;
      }
    } catch (e) {
      print(e);
      LogUtil.showToast('登录失败！');
      return false;
    } finally {
      LoadingUtil.hideLoading(context);
    }
  }
  // Future<User>  refreshLogin()async {

  // }
  /// 保存用户信息到 sp
  _saveUserInfo(User user)async {
    _user = user;
    await Application.storage?.setString('user', json.encode(user.toJson()));
  }
  clearUser(){
     _user = null;
  }
}
