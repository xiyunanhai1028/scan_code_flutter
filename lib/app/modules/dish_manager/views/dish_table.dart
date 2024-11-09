/*
 * @Author: dfh
 * @Date: 2024-10-11 15:14:33
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */

import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/modules/dish_manager/models/dish_vo_model.dart';
import 'package:flutter_pc_manager/app/modules/dish_manager/views/dish_table_search.dart';
import 'package:flutter_pc_manager/network/http_options.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../config/GlobalColor.dart';
import '../../../components/pagination_widget.dart';
import '../../../components/status_widget.dart';
import '../controllers/dish_manager_controller.dart';

class DishTable extends StatelessWidget {
  final DishManagerController controller;

  const DishTable({super.key, required this.controller});

  List<DataColumn> _getDataColumn() {
    return ['菜品名称', '图片', '菜品分类', '售价', '售卖状态', '最后操作时间', '操作']
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

  List<DataRow> _getDataRow(BuildContext context, List<DishItem> records) {
    return records
        .asMap()
        .entries
        .map(
          (item) => DataRow(
            cells: [
              DataCell(Text(item.value.name)),
              DataCell(Container(
                width: 40,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.network(
                  '${HttpOptions.BASE_IMAGE_URL}=${item.value.image}',
                  fit: BoxFit.cover,
                ),
              )),
              DataCell(Text('${item.value.categoryName ?? ''}')),
              DataCell(Text('${item.value.price}')),
              DataCell(StatusWidget(status: item.value.status)),
              DataCell(Text(item.value.updateTime)),
              DataCell(Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.fetchDishDetail(item.value.id);
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
                      controller.deleteDish(context, item.value.id);
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
                      item.value.status == 1 ? '停售' : '启售',
                      style: TextStyle(
                          color: item.value.status == 0
                              ? Colors.blue
                              : Colors.red[300]),
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
            Obx(() => DishTableSearch(
                  controller: controller,
                  categoryOptions: controller.categoryOptions.value,
                )),
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: double.infinity,
              child: Obx(
                () => DataTable(
                  border: TableBorder.symmetric(
                      outside: const BorderSide(color: GlobalColor.bgColor)),
                  columns: _getDataColumn(),
                  rows: _getDataRow(context, controller.dishList.value),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Obx(() => PaginationWidget(
                page: controller.searchOptions.value.page!,
                total: controller.total.value,
                onPageChange: (int currentPage) {
                  controller.searchOptions.value.page = currentPage;
                  controller.fetchTableData(
                      dishSearch: controller.searchOptions.value);
                },
              )),
        )
      ],
    );
  }
}
