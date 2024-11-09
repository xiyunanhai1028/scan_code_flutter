/*
 * @Author: dfh
 * @Date: 2024-10-09 09:33:46
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/modules/employee_manager/providers/employee_manager_provider.dart';
import 'package:flutter_pc_manager/bean/search_model.dart';
import 'package:get/get.dart';
import '../../../components/default_dialog_widget.dart';
import '../models/employee_dto_model.dart';
import '../models/employee_model.dart';

class EmployeeManagerController extends GetxController {
  final EmployeeManagerProvider _elementManagerProvider =
      EmployeeManagerProvider();

  //员工列表
  final records = Rx<List<Record>>([]);
  final total = 0.obs;
  //搜索条件
  final searchOptions = SearchModel(page: 1, pageSize: 10).obs;

  final isEditor = false.obs;

  //保存/修改数据
  final employeeDto = EmployeeDto().obs;

  //新增用户
  void saveOrUpdateEmployee() async {
    try {
      dynamic result = employeeDto.value.id == null
          ? await _elementManagerProvider.addEmployee(employeeDto.value)
          : await _elementManagerProvider.updateEmployee(employeeDto.value);
      int code = result['code'];
      if (code == 1) {
        employeeDto.value = EmployeeDto();
        isEditor.value = false;
        searchOptions.value.page = 1;
        getEmployeeList();
      } else {
        String msg = result['msg'];
        Get.snackbar('错误', msg);
      }
    } catch (e) {
      dynamic error = e;
      Get.snackbar('错误', error.message ?? '网络异常');
    }
  }

  void getEmployeeList() async {
    try {
      dynamic result =
          await _elementManagerProvider.fetchEmployeeList(searchOptions.value);
      int code = result['code'];
      if (code == 1) {
        EmployeeModel data = EmployeeModel.fromJson(result['data']);
        total.value = data.total;
        records.value = data.records;
      } else {
        String msg = result['msg'];
        Get.snackbar('错误', msg);
      }
    } catch (e) {
      dynamic error = e;
      Get.snackbar('错误', error.message ?? '网络异常');
    }
  }

  //更新员工状态
  void updateEmployeeStatus(BuildContext context, Record item) {
    try {
      String title = item.status == 1 ? '禁用' : '启用';
      showDialog(
        context: context,
        builder: (context) => DefaultDialogWidget(
          width: 340,
          height: 220,
          title: title,
          content: '您确定要$title${item.name}吗？',
          onConfirm: () async {
            try {
              dynamic result = await _elementManagerProvider.updateStatus(
                  item.status == 1 ? 0 : 1, item.id);
              int code = result['code'];
              if (code == 1) {
                Get.back();
                getEmployeeList();
              } else {
                String msg = result['msg'];
                Get.snackbar('错误', msg);
              }
            } catch (e) {
              dynamic error = e;
              Get.snackbar('错误', error.message ?? '网络异常');
            }
          },
          onCancel: () {
            Get.back();
          },
        ),
      );
    } catch (e) {
      dynamic error = e;
      Get.snackbar('错误', error.message ?? '网络异常');
    }
  }

  //更新员工状态
  void deleteEmployee(BuildContext context, Record item) {
    try {
      showDialog(
        context: context,
        builder: (context) => DefaultDialogWidget(
          width: 340,
          height: 220,
          title: '删除',
          content: '您确定要删除${item.name}吗？',
          onConfirm: () async {
            try {
              dynamic result =
                  await _elementManagerProvider.deleteEmployee(item.id);
              int code = result['code'];
              if (code == 1) {
                Get.back();
                getEmployeeList();
              } else {
                String msg = result['msg'];
                Get.snackbar('错误', msg);
              }
            } catch (e) {
              dynamic error = e;
              Get.snackbar('错误', error.message ?? '网络异常');
            }
          },
          onCancel: () {
            Get.back();
          },
        ),
      );
    } catch (e) {
      dynamic error = e;
      Get.snackbar('错误', error.message ?? '网络异常');
    }
  }

  //获取员工相信信息
  void fetchEmployeeDetail(int id) async {
    try {
      dynamic result = await _elementManagerProvider.fetchEmployeeDetail(id);
      int code = result['code'];
      if (code == 1) {
        EmployeeDto data = EmployeeDto.fromJson(result['data']);
        employeeDto.value = data;
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
