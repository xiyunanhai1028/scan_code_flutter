/*
 * @Author: dfh
 * @Date: 2024-10-11 15:37:26
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter_pc_manager/bean/search_model.dart';
import 'package:flutter_pc_manager/network/http.dart';
import 'package:flutter_pc_manager/utils/Utils.dart';
import 'package:get/get_connect.dart';

class SetmealManagerProvider extends GetConnect {
  //获取表单数据
  Future<dynamic> fetchSetmealList(SearchModel? searchModel) async {
    String params = Utils.resoveOptions(searchModel);
    print('params-$params');
    return await Http.get('/setmeal/page?$params');
  }

  //分类列表-套餐
  Future<dynamic> fetchCategoryList() async {
    return await Http.get('/category/list?type=2');
  }

  //分类列表-all
  Future<dynamic> fetchCategoryListAll() async {
    return await Http.get('/category/all/list');
  }

  //分类列表-菜品
  Future<dynamic> fetchCategoryListDish() async {
    return await Http.get('/category/list?type=1');
  }

  //保存套餐
  Future<dynamic> saveSetmeal(data) async {
    return await Http.post('/setmeal', data: data);
  }

//获取菜品详情
  Future<dynamic> fetchSetmealDetail(int id) async {
    return await Http.get('/setmeal/$id');
  }

  //更新套餐
  Future<dynamic> updateSetmeal(data) async {
    return await Http.put('/setmeal', data: data);
  }

  //启用/禁用套餐
  Future<dynamic> updateState(int status, int id) async {
    return await Http.post('/setmeal/status/$status?id=$id');
  }

  //删除套餐
  Future<dynamic> deleteSetmeal(int id) async {
    return await Http.delete('/setmeal', params: {'ids': id});
  }

  //删除套餐
  Future<dynamic> fetchDishById(int categoryId) async {
    return await Http.get('/dish/list?categoryId=$categoryId');
  }
}
