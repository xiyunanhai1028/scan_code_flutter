/*
 * @Author: dfh
 * @Date: 2024-10-09 07:34:54
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter_pc_manager/network/http.dart';
import 'package:get/get_connect.dart';

class LoginProvider extends GetConnect {
  //账号登录
  Future<dynamic> fetchLogin(dynamic data) async {
    return await Http.post('/employee/login', data:data);
  }
}
