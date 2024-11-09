/*
 * @Author: dfh
 * @Date: 2024-10-09 09:50:11
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/modules/dish_manager/models/dish_dto_model.dart';
import 'package:flutter_pc_manager/app/modules/dish_manager/models/dish_vo_model.dart';
import 'package:flutter_pc_manager/app/modules/dish_manager/providers/dish_manager_provider.dart';
import 'package:flutter_pc_manager/bean/options_model.dart';
import 'package:flutter_pc_manager/bean/search_model.dart';
import 'package:get/get.dart';

import '../../../components/default_dialog_widget.dart';
import '../models/category_options.dart';

class DishManagerController extends GetxController {
  final DishManagerProvider _provider = DishManagerProvider();
  //表单总数
  final total = 0.obs;
  //表单数据
  final dishList = Rx<List<DishItem>>([]);
  //分类列表数据
  final categoryOptions = Rx<List<OptionsBean>>([]);
  //新增或修改页面
  final isAddOrEditor = false.obs;
  //新增 or 修改参数对象
  final dishDTO = DishDto().obs;
  //搜索数据
  final searchOptions = SearchModel(page: 1, pageSize: 10).obs;

  //查询菜品列表
  void fetchTableData({SearchModel? dishSearch}) async {
    try {
      dynamic result = await _provider.fetchDishList(dishSearch);
      int code = result['code'];
      if (code == 1) {
        DishVo data = DishVo.fromJson(result['data']);
        print("菜品表单数据:${data.toJson()}");
        total.value = data.total;
        dishList.value = data.records;
      } else {
        String msg = result['msg'];
        Get.snackbar('错误', msg);
      }
    } catch (e) {
      dynamic error = e;
      Get.snackbar('错误', error.message ?? '网络异常');
    }
  }

  //保存/更新菜品
  void saveOrUpdateDish() async {
    try {
      dynamic result = dishDTO.value.id != null
          ? await _provider.updateDish(dishDTO.value)
          : await _provider.saveDish(dishDTO.value);
      int code = result['code'];
      if (code == 1) {
        Get.snackbar('成功', dishDTO.value.id != null ? '修改菜品成功' : '新增菜品成功');
        isAddOrEditor.value = false;
        fetchTableData();
      } else {
        String msg = result['msg'];
        Get.snackbar('错误', msg);
      }
    } catch (e) {
      dynamic error = e;
      Get.snackbar('错误', error.message ?? '网络异常');
    }
  }

  //获取分类列表
  void fetchCategoryList() async {
    try {
      dynamic result = await _provider.fetchCategoryList();
      int code = result['code'];
      if (code == 1) {
        List<CategoryOptions> data =
            categoryOptionsFromJson(json.encode(result['data']));
        if (data.isNotEmpty) {
          List<OptionsBean> list = [];
          for (CategoryOptions element in data) {
            list.add(OptionsBean(value: '${element.id}', label: element.name));
          }
          categoryOptions.value = list;
        }
      } else {
        String msg = result['msg'];
        Get.snackbar('错误', msg);
      }
    } catch (e) {
      dynamic error = e;
      Get.snackbar('错误', error.message ?? '网络异常');
    }
  }

  //更新状态
  void updateStatus(BuildContext context, int status, int id) {
    String title = status == 1 ? '停售' : '启售';
    showDialog(
      context: context,
      builder: (context) => DefaultDialogWidget(
        width: 340,
        title: title,
        content: '您确定要$title吗？',
        onConfirm: () async {
          try {
            dynamic result =
                await _provider.updateState(status == 1 ? 0 : 1, id);
            int code = result['code'];
            if (code == 1) {
              Get.back();
              fetchTableData();
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
  }

  //删除菜品
  void deleteDish(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) => DefaultDialogWidget(
        width: 340,
        title: '删除',
        content: '您确定要删除此菜品吗？',
        onConfirm: () async {
          try {
            dynamic result = await _provider.deleteDish(id);
            int code = result['code'];
            if (code == 1) {
              Get.back();
              fetchTableData();
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
  }

  //获取菜品详情
  void fetchDishDetail(int id) async {
    try {
      dynamic result = await _provider.fetchDishDetail(id);
      int code = result['code'];
      if (code == 1) {
        DishDto dishVo = DishDto.fromJson(result['data']);
        dishDTO.value = dishVo;
        isAddOrEditor.value = true;
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
