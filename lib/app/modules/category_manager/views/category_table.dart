/*
 * @Author: dfh
 * @Date: 2024-10-09 16:39:56
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
/*
 * @Author: dfh
 * @Date: 2024-10-09 16:39:56
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/components/button_small_widget.dart';
import 'package:flutter_pc_manager/app/components/dialog_widget.dart';
import 'package:flutter_pc_manager/app/components/icon_button_small_widget.dart';
import 'package:flutter_pc_manager/app/components/select_widget.dart';
import 'package:flutter_pc_manager/app/components/text_form_field_widget.dart';
import 'package:flutter_pc_manager/app/modules/category_manager/controllers/category_manager_controller.dart';
import 'package:flutter_pc_manager/app/modules/category_manager/models/category_vo_model.dart';
import 'package:flutter_pc_manager/app/modules/category_manager/models/catgory_dto_model.dart';
import 'package:flutter_pc_manager/bean/options_model.dart';
import 'package:flutter_pc_manager/config/GlobalColor.dart';
import 'package:get/get.dart';
import '../../../components/pagination_widget.dart';
import '../../../components/status_widget.dart';

class CategoryTable extends StatelessWidget {
  final CategoryManagerController controller;

  final GlobalKey _formKey = GlobalKey<FormState>();

  CategoryTable({super.key, required this.controller});

  final List<OptionsBean> options = [
    OptionsBean(value: '1', label: '菜品'),
    OptionsBean(value: '2', label: '套餐'),
  ];

  void addOrEditor(BuildContext context, int type, Category? category) {
    //保存修改所需数据
    final categoryDTO = CategoryDto();
    if (category == null) {
      categoryDTO.type = type;
    } else {
      categoryDTO.id = category.id;
      categoryDTO.name = category.name;
      categoryDTO.sort = category.sort;
      categoryDTO.type = category.type;
    }
    String title = category == null ? '新增' : '编辑';
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: DialogWidget(
          title: type == 1 ? '$title菜品' : '$title套餐',
          height: 340,
          onConfirm: () {
            if ((_formKey.currentState as FormState).validate()) {
              Get.back();
              if (category == null) {
                controller.saveCategory(categoryDTO);
              } else {
                controller.updateCategory(categoryDTO);
              }
            }
          },
          onCancel: () {
            Get.back();
          },
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormFieldWidget(
                  label: '分类名称',
                  text: category == null ? '' : category.name,
                  required: true,
                  onChange: (String v) {
                    categoryDTO.name = v;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormFieldWidget(
                  label: '排序',
                  text: category == null ? '' : '${category.sort}',
                  required: true,
                  onChange: (String v) {
                    if (v.isNotEmpty) {
                      int value = int.parse(v!);
                      categoryDTO.sort = value;
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 250,
              height: 40,
              margin: const EdgeInsets.only(right: 10),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    hintText: '请输入分类姓名'),
                onChanged: (v) {
                  controller.searchOptions.value.name = v!;
                },
              ),
            ),
            SelectWidget(
              label: "分类类型",
              options: options,
              callback: (String? v) {
                if (v != null) {
                  controller.searchOptions.value.type = int.parse(v!);
                } else {
                  controller.searchOptions.value.type = null;
                }
              },
            ),
            ButtonSmallWidget(
              text: "查询",
              onPressed: () {
                controller.fetchCategoryList();
              },
            ),
          ],
        ),
        Row(
          children: [
            IconButtonSmallWidget(
              width: 160,
              label: "新增菜品分类",
              iconData: Icons.add,
              onPressed: () {
                addOrEditor(context, 1, null);
              },
            ),
            const SizedBox(
              width: 20,
            ),
            IconButtonSmallWidget(
              width: 160,
              label: "新增套餐分类",
              iconData: Icons.add,
              color: Colors.white,
              backgroundColor: Colors.black,
              onPressed: () {
                addOrEditor(context, 2, null);
              },
            ),
          ],
        )
      ],
    );
  }

  List<DataColumn> _getDataColumn() {
    return ['分类名称', '分类类型', '排序', '状态', '操作时间', '操作']
        .map(
          (label) => DataColumn(
            label: Expanded(
              flex: 1,
              child: Text(
                label,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
          ),
        )
        .toList();
  }

  List<DataRow> _getDataRow(BuildContext context, List<Category> records) {
    return records
        .asMap()
        .entries
        .map(
          (item) => DataRow(
            cells: [
              DataCell(Text(item.value.name)),
              DataCell(Text(item.value.type == 1 ? '菜品分类' : '套餐分类')),
              DataCell(Text('${item.value.sort}')),
              DataCell(StatusWidget(status: item.value.status)),
              DataCell(Text(item.value.updateTime)),
              DataCell(Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      addOrEditor(context, item.value.type, item.value);
                    },
                    child: const Text(
                      '修改',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.deleteCategory(
                          context, item.value.name, item.value.id);
                    },
                    child: Text(
                      '删除',
                      style: TextStyle(color: Colors.red[300]),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.updateStatus(
                          context, item.value.status, item.value.id);
                    },
                    child: Text(
                      item.value.status == 1 ? '禁用' : '启用',
                      style: TextStyle(
                          color: item.value.status == 1
                              ? Colors.red[300]
                              : Colors.blue),
                    ),
                  ),
                ],
              )),
            ],
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(0),
          children: [
            _getHeader(context),
            Obx(() => Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: double.infinity,
                  child: DataTable(
                    border: TableBorder.symmetric(
                        outside: const BorderSide(color: GlobalColor.bgColor)),
                    columns: _getDataColumn(),
                    rows: _getDataRow(context, controller.categoryList.value),
                  ),
                ))
          ],
        ),
        Obx(
          () => Positioned(
            bottom: 0,
            right: 0,
            child: PaginationWidget(
              page: controller.searchOptions.value.page ?? 1,
              total: controller.total.value,
              onPageChange: (int currentPage) {
                controller.searchOptions.value.page = currentPage;
                controller.fetchCategoryList();
              },
            ),
          ),
        )
      ],
    );
  }
}
