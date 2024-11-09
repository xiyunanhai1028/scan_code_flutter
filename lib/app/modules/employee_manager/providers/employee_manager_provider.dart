/*
 * @Author: dfh
 * @Date: 2024-09-30 10:19:26
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter_pc_manager/bean/search_model.dart';
import 'package:flutter_pc_manager/network/http.dart';
import 'package:flutter_pc_manager/utils/Utils.dart';
import 'package:get/get_connect.dart';

class EmployeeManagerProvider extends GetConnect {
  //新增员工
  Future<dynamic> addEmployee(dynamic data) async {
    return await Http.post('/employee', data: data);
  }

  //新增员工
  Future<dynamic> updateEmployee(dynamic data) async {
    return await Http.put('/employee', data: data);
  }

  //获取员工列表
  Future<dynamic> fetchEmployeeList(SearchModel options) async {
    String params = Utils.resoveOptions(options);
    return await Http.get('/employee/page?$params');
  }

  //启用 or 禁用
  Future<dynamic> updateStatus(int status, int id) async {
    return await Http.post('/employee/status/$status?id=$id');
  }

  //删除
  Future<dynamic> deleteEmployee(int id) async {
    return await Http.post('/employee/delete', params: {"id": id});
  }

  //获取详情
  Future<dynamic> fetchEmployeeDetail(int id) async {
    return await Http.get('/employee/$id');
  }
}
