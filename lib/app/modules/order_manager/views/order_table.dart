import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/modules/order_manager/models/order_manager_model.dart';
import 'package:flutter_pc_manager/app/modules/order_manager/views/order_search.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../config/GlobalColor.dart';
import '../controllers/order_manager_controller.dart';

class OrderTable extends StatelessWidget {
  final OrderManagerController controller;
  const OrderTable({super.key, required this.controller});

  List<DataColumn> _getDataColumn() {
    return ['订单号', '桌位号', '订单状态', '用户名', '手机号', '下单时间', '实收金额', '操作']
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

  //订单状态 1排队 2做餐 3出餐 4已完成 5已取消 6已退款 7已评论
  Widget _getOrderStatus(int status) {
    if (status == 1) {
      return const Text(
        '排队中',
        style: TextStyle(color: Colors.red),
      );
    }
    if (status == 2) {
      return const Text(
        '做餐中',
        style: TextStyle(color: Colors.orange),
      );
    }
    if (status == 3) {
      return Text(
        '出餐中',
        style: TextStyle(color: Colors.blue[400]),
      );
    }
    if (status == 4 || status == 7) {
      return Text(
        '已完成',
        style: TextStyle(color: Colors.green[400]),
      );
    }
    if (status == 5) {
      return const Text(
        '已取消',
        style: TextStyle(color: Colors.grey),
      );
    }
    if (status == 6) {
      return const Text(
        '已退款',
        style: TextStyle(color: Colors.grey),
      );
    }
    return const Text(
      '排队中',
      style: TextStyle(color: Colors.red),
    );
  }

  //操作按钮区域: 接单、出餐
  Widget _getToDo(
      BuildContext context, int status, int payStatus, String number) {
    if (status > 3) {
      return const SizedBox(
        child: Text('- -'),
      );
    }
    return GestureDetector(
      onTap: () {
        controller.updateOrdersStatus(context, status, number);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
            color: status == 1
                ? Colors.red
                : status == 2
                    ? Colors.orange[400]
                    : Colors.blue[400],
            borderRadius: BorderRadius.circular(6)),
        child: Text(
          //  订单状态 1排队 2做餐 3出餐 4已完成 5已取消 6已退款 7已评论
          status == 1
              ? '待接单'
              : status == 2
                  ? '待出餐'
                  : '完成出餐',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  List<DataRow> _getDataRow(BuildContext context, List<OrderItem> records) {
    return records
        .asMap()
        .entries
        .map(
          (item) => DataRow(
            cells: [
              DataCell(Text(item.value.number ?? '')),
              DataCell(Text('${item.value.sitNum}号位')),
              // 订单状态 1待付款 2待接单 3已接单 4派送中 5已完成 6已取消 7退款
              DataCell(_getOrderStatus(item.value.status)),
              DataCell(Text('${item.value.userName ?? '未认证'}')),
              DataCell(Text(item.value.phone ?? '--')),
              DataCell(Text(item.value.orderTime ?? '')),
              DataCell(Text('${item.value.amount ?? 0.00}')),
              DataCell(_getToDo(context, item.value.status,
                  item.value.payStatus, item.value.number)),
            ],
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(0), children: [
      OrderSeach(controller: controller),
      Obx(
        () => Container(
          margin: const EdgeInsets.only(top: 10),
          width: double.infinity,
          child: DataTable(
            border: TableBorder.symmetric(
                outside: const BorderSide(color: GlobalColor.bgColor)),
            columns: _getDataColumn(),
            rows: _getDataRow(context, controller.orderList.value),
          ),
        ),
      ),
    ]);
  }
}
