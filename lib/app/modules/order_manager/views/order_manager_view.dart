/*
 * @Author: dfh
 * @Date: 2024-10-15 10:13:41
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/modules/order_manager/views/order_table.dart';

import '../controllers/order_manager_controller.dart';

class OrderManagerView extends StatefulWidget {
  const OrderManagerView({super.key});

  @override
  State<OrderManagerView> createState() => _OrderManagerViewState();
}

class _OrderManagerViewState extends State<OrderManagerView> {
  final _controller = OrderManagerController();

  @override
  void initState() {
    super.initState();
    _controller.websocketListener();
    _controller.fetchTableData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.white),
      child: OrderTable(controller: _controller),
    );
  }
}
