/*
 * @Author: dfh
 * @Date: 2024-10-15 10:13:28
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/modules/setmeal_manager/models/setmeal_dto_model.dart';
import 'package:flutter_pc_manager/app/modules/setmeal_manager/models/setmeal_vo_model.dart';
import 'package:flutter_pc_manager/bean/options_model.dart';
import 'package:flutter_pc_manager/bean/search_model.dart';
import 'package:get/get.dart';

import '../../../components/default_dialog_widget.dart';
import '../../dish_manager/models/category_options.dart';
import '../models/dish_vo_list.dart';
import '../providers/setmeal_manager_provider.dart';

class SetmealManagerController extends GetxController {
  final SetmealManagerProvider _provider = SetmealManagerProvider();
  //总条数
  final total = 0.obs;
  //table数据
  final setmealList = Rx<List<SetmealItem>>([]);
  //分类数据
  final categoryOptions = Rx<List<OptionsBean>>([]);
  //所有的分类
  final categoryAll = Rx<List<CategoryOptions>>([]);
  //新增或修改页面
  final isAddOrEditor = false.obs;
  //搜索数据
  final searchOptions = SearchModel(page: 1, pageSize: 10).obs;
  //新增 or 修改参数对象
  final setmealDTO = SetmealDto().obs;
  //菜品列表
  final dishList = Rx<List<DishVoList>>([]);

  void fetchTableData({SearchModel? searchModel}) async {
    try {
      dynamic result = await _provider.fetchSetmealList(searchModel);
      int code = result['code'];
      if (code == 1) {
        SetmealVo data = SetmealVo.fromJson(result['data']);
        print(data.toJson());
        total.value = data.total;
        setmealList.value = data.records;
      } else {
        String msg = result['msg'];
        Get.snackbar('错误', msg);
      }
    } catch (e) {
      dynamic error = e;
      Get.snackbar('错误', error.message ?? '网络异常');
    }
  }

  //保存/更新套餐
  void saveOrUpdateDish() async {
    try {
      dynamic result = setmealDTO.value.id != null
          ? await _provider.updateSetmeal(setmealDTO.value)
          : await _provider.saveSetmeal(setmealDTO.value);
      int code = result['code'];
      if (code == 1) {
        Get.snackbar('成功', setmealDTO.value.id != null ? '修改套餐成功' : '新增套餐成功');
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
          for (var element in data) {
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
  void updateStatus(BuildContext context, SetmealItem item) {
    String title = item.status == 1 ? '停售' : '启售';
    showDialog(
      context: context,
      builder: (context) => DefaultDialogWidget(
        width: 340,
        height: 220,
        title: title,
        content: '您确定要$title${item.name}吗？',
        onConfirm: () async {
          try {
            dynamic result =
                await _provider.updateState(item.status == 1 ? 0 : 1, item.id);
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
  void deleteDish(BuildContext context, SetmealItem item) {
    showDialog(
      context: context,
      builder: (context) => DefaultDialogWidget(
        width: 340,
        height: 220,
        title: '删除',
        content: '您确定要删除此${item.name}吗？',
        onConfirm: () async {
          try {
            dynamic result = await _provider.deleteSetmeal(item.id);
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
      dynamic result = await _provider.fetchSetmealDetail(id);
      int code = result['code'];
      if (code == 1) {
        SetmealDto setmealVo = SetmealDto.fromJson(result['data']);
        setmealDTO.value = setmealVo;
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

  //获取分类列表
  void fetchCategoryDish() async {
    try {
      dynamic result = await _provider.fetchCategoryListDish();
      int code = result['code'];
      if (code == 1) {
        List<CategoryOptions> data =
            categoryOptionsFromJson(json.encode(result['data']));
        if (data.isNotEmpty) {
          categoryAll.value = data;
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

  //根据分类ID获取菜品
  void fetchDishById(int id) async {
    try {
      dynamic result = await _provider.fetchDishById(id);
      int code = result['code'];
      if (code == 1) {
        List<DishVoList> data = dishVoListFromJson(json.encode(result['data']));
        dishList.value = data;
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
