import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/lib/data/models/userModels.dart';

class AuthController {
  static String? token;
  static UserModel? user;


  static Future<void> SaveUserInformation(String t, UserModel model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', t);
    await prefs.setString('user', jsonEncode(model.toJson()));
    token = t;
    user = model;
  }


  static Future<void> intilializeUserCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    user = UserModel.fromJson(jsonDecode(prefs.getString('user') ?? '{}'));
  }


  static Future<bool> CheckAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    if (token != null) {
      intilializeUserCache();
      return true;
    }
    return false;
  }


  static Future<void> clearAuthData () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    token=null;
  }



}
