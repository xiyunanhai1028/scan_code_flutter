import 'package:get/get.dart';

import '../controllers/order_manager_controller.dart';

class OrderManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderManagerController>(
      () => OrderManagerController(),
    );
  }
}
