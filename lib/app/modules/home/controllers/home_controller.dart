/*
 * @Author: dfh
 * @Date: 2024-09-20 17:12:28
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */

import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/modules/home/models/shop_model.dart';
import 'package:flutter_pc_manager/app/modules/home/providers/shop_provider.dart';
import 'package:flutter_pc_manager/app/modules/order_manager/views/order_manager_view.dart';
import 'package:flutter_pc_manager/app/modules/setmeal_manager/views/setmeal_manager_view.dart';
import 'package:flutter_pc_manager/app/modules/shop_manager/views/shop_manager_view.dart';
import 'package:flutter_pc_manager/app/modules/statistics_manager/views/statistics_manager_view.dart';
import 'package:flutter_pc_manager/utils/shared_preferences_utils.dart';
import 'package:get/get.dart';
import 'package:flutter_pc_manager/app/modules/category_manager/views/category_manager_view.dart';
import 'package:flutter_pc_manager/app/modules/dish_manager/views/dish_manager_view.dart';
import 'package:flutter_pc_manager/app/modules/employee_manager/views/employee_manager_view.dart';

import '../../../../utils/nau_icon.dart';

class HomeController extends GetxController {
  final ShopProvider _provider = ShopProvider();

  final currentNavIndex = 0.obs;
  final username = ''.obs;
  final mainContent = Rx<List<Widget>>([
    const EmployeeManagerView(),
    const CategoryManagerView(),
    const DishManagerView(),
    const SetmealManagerView(),
    const OrderManagerView(),
    const StatisticsManagerView(),
    const ShopManagerView(),
  ]);

  final navList = Rx<List<Map<String, Object>>>([
    {'label': '员工管理', 'img': NauIcon.userManager},
    {'label': '分类管理', 'img': NauIcon.categoryManager},
    {'label': '菜单管理', 'img': NauIcon.dishManager},
    {'label': '套餐管理', 'img': NauIcon.setmealManager},
    {'label': '订单管理', 'img': NauIcon.orderManager},
    {'label': '统计管理', 'img': NauIcon.statisManager},
    {'label': '店铺管理', 'img': NauIcon.shopManager},
  ]);

  //接口返回数据
  final shopInfo = ShopModel().obs;

  @override
  void onInit() async {
    super.onInit();
    fetchShopInfo();
    username.value = await SharedPreferenceUtils.readData('username');
    String role = await SharedPreferenceUtils.readData('role');
    if (role == '0') {
      mainContent.value = [
        const CategoryManagerView(),
        const DishManagerView(),
        const SetmealManagerView(),
        const OrderManagerView()
      ];
      navList.value = [
        {'label': '分类管理', 'img': NauIcon.categoryManager},
        {'label': '菜单管理', 'img': NauIcon.dishManager},
        {'label': '套餐管理', 'img': NauIcon.setmealManager},
        {'label': '订单管理', 'img': NauIcon.orderManager},
      ];
    }
  }

  //nav下标变化
  void onCurrentNavIndexChange(int index) {
    currentNavIndex.value = index;
  }

  //获取店铺信息
  void fetchShopInfo() async {
    try {
      dynamic result = await _provider.fetchShopInfo();
      int code = result['code'];
      if (code == 1) {
        ShopModel data = ShopModel.fromJson(result['data']);
        shopInfo.value = data;
      } else {
        String msg = result['msg'];
        Get.snackbar('错误', msg);
      }
    } catch (e) {
      dynamic error = e;
      Get.snackbar('错误', error.message ?? '网络异常');
    }
  }

  //更新店铺信息
  void updateShopInfo() async {
    try {
      dynamic result = await _provider.updateShopInfo(shopInfo.value);
      int code = result['code'];
      if (code == 1) {
        ShopModel data = ShopModel.fromJson(result['data']);
        shopInfo.value = data;
      } else {
        String msg = result['msg'];
        Get.snackbar('错误', msg);
      }
    } catch (e) {
      dynamic error = e;
      Get.snackbar('错误', error.message ?? '网络异常');
    }
  }

  //设置店铺营业与大洋
  void updateShopStatus() async {
    try {
      int status = shopInfo.value.status == 0 ? 1 : 0;
      dynamic result =
          await _provider.updateShopStatus(shopInfo.value.id!, status);
      int code = result['code'];
      if (code == 1) {
        fetchShopInfo();
      } else {
        String msg = result['msg'];
        Get.snackbar('错误', msg);
      }
    } catch (e) {
      dynamic error = e;
      Get.snackbar('错误', error.message ?? '网络异常');
    }
  }
}
