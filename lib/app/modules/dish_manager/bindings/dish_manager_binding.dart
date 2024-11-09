import 'package:get/get.dart';

import '../controllers/dish_manager_controller.dart';

class DishManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DishManagerController>(
      () => DishManagerController(),
    );
  }
}
