import 'package:get/get.dart';

import '../controllers/category_manager_controller.dart';

class CategoryManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryManagerController>(
      () => CategoryManagerController(),
    );
  }
}
