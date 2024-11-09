/*
 * @Author: dfh
 * @Date: 2024-10-09 09:49:58
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/components/default_dialog_widget.dart';
import 'package:flutter_pc_manager/app/modules/category_manager/models/category_vo_model.dart';
import 'package:flutter_pc_manager/app/modules/category_manager/models/catgory_dto_model.dart';
import 'package:flutter_pc_manager/app/modules/category_manager/providers/category_manager_provider.dart';
import 'package:flutter_pc_manager/bean/search_model.dart';
import 'package:get/get.dart';

class CategoryManagerController extends GetxController {
  final CategoryManagerProvider _categoryManagerProvider =
      CategoryManagerProvider();

  final total = 0.obs;
  final categoryList = Rx<List<Category>>([]);
  //搜索条件
  final searchOptions = SearchModel(page: 1, pageSize: 10).obs;

  //获取表单数据
  void fetchCategoryList() async {
    try {
      dynamic result =
          await _categoryManagerProvider.fetchCategoryList(searchOptions.value);
      int code = result['code'];
      if (code == 1) {
        CategoryVo data = CategoryVo.fromJson(result['data']);
        total.value = data.total;
        categoryList.value = data.records;
      } else {
        String msg = result['msg'];
        Get.snackbar('错误', msg);
      }
    } catch (e) {
      dynamic error = e;
      Get.snackbar('错误', error.message ?? '网络异常');
    }
  }

  void saveCategory(CategoryDto categoryDto) async {
    try {
      dynamic result = await _categoryManagerProvider.saveCategory(categoryDto);
      int code = result['code'];
      if (code == 1) {
        Get.snackbar('成功', '新增成功');
        searchOptions.value.page = 1;
        fetchCategoryList();
      } else {
        String msg = result['msg'];
        Get.snackbar('错误', msg);
      }
    } catch (e) {
      dynamic error = e;
      Get.snackbar('错误', error.message ?? '网络异常');
    }
  }

  void updateCategory(CategoryDto categoryDto) async {
    try {
      dynamic result =
          await _categoryManagerProvider.updateCategory(categoryDto);
      int code = result['code'];
      if (code == 1) {
        Get.back();
        searchOptions.value.page = 1;
        fetchCategoryList();
      } else {
        String msg = result['msg'];
        Get.snackbar('错误', msg);
      }
    } catch (e) {
      dynamic error = e;
      Get.snackbar('错误', error.message ?? '网络异常');
    }
  }

  void updateStatus(BuildContext context, int status, int id) {
    String title = status == 1 ? '禁用' : '启用';
    showDialog(
      context: context,
      builder: (context) => DefaultDialogWidget(
        width: 340,
        title: title,
        content: '您确定要$title吗？',
        onConfirm: () async {
          try {
            dynamic result = await _categoryManagerProvider.updateState(
                status == 1 ? 0 : 1, id);
            int code = result['code'];
            if (code == 1) {
              Get.back();
              searchOptions.value.page = 1;
              fetchCategoryList();
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

  void deleteCategory(BuildContext context, String name, int id) {
    showDialog(
      context: context,
      builder: (context) => DefaultDialogWidget(
        width: 340,
        height: 210,
        title: '删除',
        content: '您确定要删除$name吗？',
        onConfirm: () async {
          try {
            dynamic result = await _categoryManagerProvider.deleteCategory(id);
            int code = result['code'];
            if (code == 1) {
              Get.back();
              searchOptions.value.page = 1;
              fetchCategoryList();
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
}
