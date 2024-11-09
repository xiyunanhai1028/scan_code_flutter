/*
 * @Author: dfh
 * @Date: 2024-09-20 16:35:56
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
/*
 * @Author: dfh
 * @Date: 2024-09-20 16:35:56
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter_pc_manager/app/modules/login/models/login_dto.dart';
import 'package:flutter_pc_manager/app/modules/login/models/login_model.dart';
import 'package:flutter_pc_manager/app/modules/login/providers/login_provider.dart';
import 'package:flutter_pc_manager/network/http.dart';
import 'package:flutter_pc_manager/utils/shared_preferences_utils.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final LoginProvider _loginProvider = LoginProvider();

  final loginInfo = LoginModel().obs;
  final loginDTO = LoginDto(username: '', password: '').obs;

  //登录
  fetchLogin() async {
    try {
      dynamic result = await _loginProvider.fetchLogin(loginDTO.value);
      int code = result['code'];
      if (code == 1) {
        LoginModel data = LoginModel.fromJson(result['data']);
        loginInfo.value = data;
        await SharedPreferenceUtils.saveData("token", data.token!);
        await SharedPreferenceUtils.saveData("username", data.name!);
        await SharedPreferenceUtils.saveData("role", '${data.role}');
        Http.setHeaders({"token": data.token!});
        Get.toNamed(Routes.HOME);
      } else {
        String msg = result['msg'];
        Get.snackbar('错误', msg);
      }
    } catch (e) {
      dynamic error = e;
      Get.snackbar("错误", error.message ?? '网络异常');
    }
  }
}
