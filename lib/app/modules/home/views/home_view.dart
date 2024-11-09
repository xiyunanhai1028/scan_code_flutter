/*
 * @Author: dfh
 * @Date: 2024-09-20 17:12:28
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';

import 'package:flutter_pc_manager/config/GlobalColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import '../../../components/header_widget.dart';
import '../../../components/left_nav_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  //main不分
  Widget _mainWidget() {
    return Obx(() => Expanded(
          flex: 1,
          child: controller.mainContent.value[controller.currentNavIndex.value],
        ));
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(1920, 1080));
    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        color: GlobalColor.bgColor,
        child: Row(
          children: [
            const LeftNavWidget(),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: double.infinity,
                child: Column(
                  children: [
                    Obx(() => HeaderWidget(
                        currentNavIndex: controller.currentNavIndex.value,
                        username: controller.username.value,
                        controller: controller)),
                    _mainWidget()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
