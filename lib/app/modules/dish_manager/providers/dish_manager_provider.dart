/*
 * @Author: dfh
 * @Date: 2024-10-11 15:37:26
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter_pc_manager/network/http.dart';
import 'package:flutter_pc_manager/utils/Utils.dart';
import 'package:get/get_connect.dart';

import '../../../../bean/search_model.dart';

class DishManagerProvider extends GetConnect {
  //获取表单数据
  Future<dynamic> fetchDishList(SearchModel? dishSearch) async {
    String params = Utils.resoveOptions(dishSearch);
    print('params-->$params');
    return await Http.get('/dish/page?$params');
  }

  //分类列表
  Future<dynamic> fetchCategoryList() async {
    return await Http.get('/category/list?type=1');
  }

  //保存菜品
  Future<dynamic> saveDish(data) async {
    return await Http.post('/dish', data: data);
  }

  //获取菜品详情
  Future<dynamic> fetchDishDetail(int id) async {
    return await Http.get('/dish/$id');
  }

  //修改菜品
  Future<dynamic> updateDish(data) async {
    return await Http.put('/dish', data: data);
  }

  //启用/禁用菜品
  Future<dynamic> updateState(int status, int id) async {
    return await Http.post('/dish/status/$status?id=$id');
  }

  //删除菜品
  Future<dynamic> deleteDish(int id) async {
    return await Http.delete('/dish', params: {'ids': id});
  }
}
