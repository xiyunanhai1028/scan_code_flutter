/*
 * @Author: dfh
 * @Date: 2024-10-15 13:45:56
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter_pc_manager/network/http.dart';
import 'package:get/get_connect.dart';

class ShopManagerProvider extends GetConnect {
  //新增店铺信息
  Future<dynamic> saveShopInfo(dynamic data) async {
    return await Http.post('/admin/shop/save', data: data);
  }

  //修改店铺信息
  Future<dynamic> updateShopInfo(dynamic data) async {
    return await Http.post('/admin/shop/update', data: data);
  }
}
