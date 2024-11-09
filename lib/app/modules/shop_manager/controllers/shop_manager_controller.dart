/*
 * @Author: dfh
 * @Date: 2024-10-15 10:12:38
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter_pc_manager/app/modules/shop_manager/models/shop_info_model.dart';
import 'package:flutter_pc_manager/app/modules/shop_manager/provider/shop_manager_provider.dart';
import 'package:get/get.dart';

class ShopManagerController extends GetxController {
  final ShopManagerProvider _shopManagerProvider = ShopManagerProvider();
  //店铺信息
  final shopInfoVo = ShopInfoVo(
          title: '',
          address: '',
          startTitle: '',
          endTime: '',
          isStart: 0,
          description: '',
          image: '')
      .obs;
  final isEditor = false.obs;
  //保存
  addShopInfo() async {
    try {
      dynamic result =
          await _shopManagerProvider.saveShopInfo(shopInfoVo.value);
      int code = result['code'];
      if (code == 1) {
        isEditor.value = false;
      } else {
        String msg = result['msg'];
        Get.snackbar('错误', msg);
      }
    } catch (e) {
      dynamic error = e;
      Get.snackbar("错误", error.message ?? '网络异常');
    }
  }

   //修改
  editorShopInfo() async {
    try {
      dynamic result =
          await _shopManagerProvider.updateShopInfo(shopInfoVo.value);
      int code = result['code'];
      if (code == 1) {
        isEditor.value = false;
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
