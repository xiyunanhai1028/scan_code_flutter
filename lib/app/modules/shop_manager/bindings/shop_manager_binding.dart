import 'package:get/get.dart';

import '../controllers/shop_manager_controller.dart';

class ShopManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopManagerController>(
      () => ShopManagerController(),
    );
  }
}
