/*
 * @Author: dfh
 * @Date: 2024-10-09 09:33:46
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:get/get.dart';

import '../controllers/employee_manager_controller.dart';

class EmployeeManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployeeManagerController>(
      () => EmployeeManagerController(),
    );
  }
}
