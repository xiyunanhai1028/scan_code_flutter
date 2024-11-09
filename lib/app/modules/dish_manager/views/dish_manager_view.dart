/*
 * @Author: dfh
 * @Date: 2024-10-09 09:50:11
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/modules/dish_manager/views/add_editor_dish.dart';
import 'package:flutter_pc_manager/app/modules/dish_manager/views/dish_table.dart';

import 'package:get/get.dart';

import '../controllers/dish_manager_controller.dart';

class DishManagerView extends StatefulWidget {
  const DishManagerView({super.key});

  @override
  State<DishManagerView> createState() => _DishManagerViewState();
}

class _DishManagerViewState extends State<DishManagerView> {
  final _controller = DishManagerController();

  @override
  void initState() {
    super.initState();
    _controller.fetchTableData();
    _controller.fetchCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6), color: Colors.white),
        child: _controller.isAddOrEditor.value
            ? AddEditorWidget(controller: _controller)
            : DishTable(controller: _controller),
      ),
    );
  }
}
