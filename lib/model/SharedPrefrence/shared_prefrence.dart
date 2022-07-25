import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static SharedPreferences? prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future putData({required String key, required bool value}) async {
    return await prefs?.setBool(key, value);
  }

 static bool?getData({required String key}) {
    return prefs?.getBool(key);
  }

}
