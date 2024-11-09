/*
 * @Author: dfh
 * @Date: 2024-10-09 09:04:14
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtils {
  // 保存数据
  static Future<void> saveData(String key, String jsonStr) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonStr);
  }

  // 读取数据
  static Future<String> readData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }
}
