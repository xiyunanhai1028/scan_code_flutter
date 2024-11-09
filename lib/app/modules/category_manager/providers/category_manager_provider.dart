/*
 * @Author: dfh
 * @Date: 2024-10-09 17:01:29
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */

import 'package:flutter_pc_manager/bean/search_model.dart';
import 'package:flutter_pc_manager/network/http.dart';
import 'package:flutter_pc_manager/utils/Utils.dart';
import 'package:get/get_connect.dart';

class CategoryManagerProvider extends GetConnect {
  //获取表单数据
  Future<dynamic> fetchCategoryList(SearchModel options) async {
    String params = Utils.resoveOptions(options);
    print('params:-->$params');
    return await Http.get('/category/page?$params');
  }

  //保存分类
  Future<dynamic> saveCategory(data) async {
    return await Http.post('/category', data: data);
  }

  //启用/禁用分类
  Future<dynamic> updateState(int status, int id) async {
    return await Http.post('/category/status/$status?id=$id');
  }

  //删除分类
  Future<dynamic> deleteCategory(int id) async {
    return await Http.delete('/category', params: {'id': id});
  }

  //修改分类
  Future<dynamic> updateCategory(data) async {
    return await Http.put('/category', data: data);
  }
}
