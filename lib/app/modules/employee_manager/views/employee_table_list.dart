/*
 * @Author: dfh
 * @Date: 2024-10-09 11:11:42
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */

import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/components/button_small_widget.dart';
import 'package:flutter_pc_manager/app/components/icon_button_small_widget.dart';
import 'package:flutter_pc_manager/app/modules/employee_manager/controllers/employee_manager_controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../components/status_widget.dart';
import '../models/employee_model.dart';

class EmployeeTableList extends StatelessWidget {
  final EmployeeManagerController controller;

  const EmployeeTableList({super.key, required this.controller});

  Widget _getHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 250,
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    hintText: '请输入员工姓名'),
                onChanged: (v) {
                  controller.searchOptions.value.name = v!;
                },
              ),
            ),
            ButtonSmallWidget(
              text: "查询",
              onPressed: () {
                controller.getEmployeeList();
              },
            ),
          ],
        ),
        IconButtonSmallWidget(
          width: 160,
          label: "新增员工",
          iconData: Icons.add,
          onPressed: () {
            controller.isEditor.value = true;
          },
        ),
      ],
    );
  }

  List<DataColumn> _getDataColumn() {
    return ['员工姓名', '账号', '角色', '手机号', '账号状态', '最后操作时间', '操作']
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

  List<DataRow> _getDataRow(BuildContext context, List<Record> records) {
    return records
        .asMap()
        .entries
        .map(
          (item) => DataRow(
            cells: [
              DataCell(Text(item.value.name)),
              DataCell(Text(item.value.username)),
              DataCell(Text(item.value.role == 1 ? '管理员' : '普通用户')),
              DataCell(Text(item.value.phone)),
              DataCell(StatusWidget(status: item.value.status)),
              DataCell(Text(item.value.updateTime)),
              DataCell(Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.fetchEmployeeDetail(item.value.id);
                      controller.isEditor.value = true;
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
                      controller.updateEmployeeStatus(context, item.value);
                    },
                    child: Text(
                      item.value.status == 1 ? '禁用' : '启用',
                      style: TextStyle(
                          color: item.value.status == 1
                              ? Colors.red[300]
                              : Colors.blue),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.deleteEmployee(context, item.value);
                    },
                    child: Text(
                      '删除',
                      style: TextStyle(
                        color: Colors.red[300],
                      ),
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
    return ListView(padding: const EdgeInsets.all(0), children: [
      _getHeader(),
      Obx(
        () => Container(
          margin: const EdgeInsets.only(top: 10),
          width: double.infinity,
          child: DataTable(
            columns: _getDataColumn(),
            rows: _getDataRow(context, controller.records.value),
          ),
        ),
      ),
    ]);
  }
}
