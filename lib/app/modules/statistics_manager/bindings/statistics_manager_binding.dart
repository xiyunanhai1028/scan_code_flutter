import 'package:get/get.dart';

import '../controllers/statistics_manager_controller.dart';

class StatisticsManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatisticsManagerController>(
      () => StatisticsManagerController(),
    );
  }
}
