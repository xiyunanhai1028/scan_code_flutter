/*
 * @Author: dfh
 * @Date: 2024-10-23 17:49:16
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter_pc_manager/network/http.dart';
import 'package:get/get_connect.dart';

class ShopProvider extends GetConnect {
  //获取店铺信息
  Future<dynamic> fetchShopInfo() async {
    return await Http.get('/shop');
  }

  //保存店铺信息
  Future<dynamic> saveShopInfo(data) async {
    return await Http.post('/shop', data: data);
  }

  //修改店铺信息
  Future<dynamic> updateShopInfo(data) async {
    return await Http.put('/shop', data: data);
  }

  //更新店铺状态
  Future<dynamic> updateShopStatus(int id, int status) async {
    return await Http.post('/shop/update/status/$status?id=$id');
  }
}
