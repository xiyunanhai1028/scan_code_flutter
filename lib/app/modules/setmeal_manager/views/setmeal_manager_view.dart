/*
 * @Author: dfh
 * @Date: 2024-10-15 10:13:28
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/modules/setmeal_manager/views/add_editor_setmeal.dart';
import 'package:flutter_pc_manager/app/modules/setmeal_manager/views/setmeal_table.dart';

import 'package:get/get.dart';

import '../controllers/setmeal_manager_controller.dart';

class SetmealManagerView extends StatefulWidget {
  const SetmealManagerView({super.key});

  @override
  State<SetmealManagerView> createState() => _SetmealManagerViewState();
}

class _SetmealManagerViewState extends State<SetmealManagerView> {
  final _controller = SetmealManagerController();

  @override
  void initState() {
    super.initState();
    _controller.fetchTableData();
    _controller.fetchCategoryList();
    _controller.fetchCategoryDish();
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
            ? AddEditorSetmeal(controller: _controller)
            : SetmealTable(controller: _controller),
      ),
    );
  }
}
