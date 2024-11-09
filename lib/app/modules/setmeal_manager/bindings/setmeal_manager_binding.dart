import 'package:get/get.dart';

import '../controllers/setmeal_manager_controller.dart';

class SetmealManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetmealManagerController>(
      () => SetmealManagerController(),
    );
  }
}
