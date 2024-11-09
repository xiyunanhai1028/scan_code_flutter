/*
 * @Author: dfh
 * @Date: 2024-10-15 15:29:32
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/components/pagination_widget.dart';
import 'package:flutter_pc_manager/app/modules/setmeal_manager/controllers/setmeal_manager_controller.dart';
import 'package:flutter_pc_manager/app/modules/setmeal_manager/models/setmeal_vo_model.dart';
import 'package:flutter_pc_manager/app/modules/setmeal_manager/views/setmeal_search.dart';
import 'package:flutter_pc_manager/network/http_options.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../config/GlobalColor.dart';
import '../../../components/status_widget.dart';

class SetmealTable extends StatelessWidget {
  final SetmealManagerController controller;

  const SetmealTable({super.key, required this.controller});

  List<DataColumn> _getDataColumn() {
    return ['套餐名称', '图片', '套餐分类', '售价', '售卖状态', '最后操作时间', '操作']
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

  List<DataRow> _getDataRow(BuildContext context, List<SetmealItem> records) {
    return records
        .asMap()
        .entries
        .map(
          (item) => DataRow(
            cells: [
              DataCell(Text(item.value.name)),
              DataCell(Container(
                width: 40,
                // height: 80,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.network(
                  '${HttpOptions.BASE_IMAGE_URL}=${item.value.image}',
                  fit: BoxFit.cover,
                ),
              )),
              DataCell(Text(item.value.categoryName)),
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
                      controller.deleteDish(context, item.value);
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
                      controller.updateStatus(context, item.value);
                    },
                    child: Text(
                      item.value.status == 1 ? '停售' : '启售',
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
            SetmealSearch(
              controller: controller,
            ),
            Obx(
              () => Container(
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                child: DataTable(
                  border: TableBorder.symmetric(
                      outside: const BorderSide(color: GlobalColor.bgColor)),
                  columns: _getDataColumn(),
                  rows: _getDataRow(context, controller.setmealList.value),
                ),
              ),
            ),
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
                controller.fetchTableData(
                    searchModel: controller.searchOptions.value);
              },
            ),
          ),
        )
      ],
    );
  }
}
