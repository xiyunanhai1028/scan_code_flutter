/*
 * @Author: dfh
 * @Date: 2024-10-09 09:33:46
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/modules/employee_manager/views/add_editor_employee.dart';
import 'package:flutter_pc_manager/app/modules/employee_manager/views/employee_table_list.dart';

import 'package:get/get.dart';
import '../controllers/employee_manager_controller.dart';

class EmployeeManagerView extends StatefulWidget {
  const EmployeeManagerView({super.key});
  @override
  State<EmployeeManagerView> createState() => _EmployeeManagerViewState();
}

class _EmployeeManagerViewState extends State<EmployeeManagerView> {
  EmployeeManagerController controller = EmployeeManagerController();

  @override
  void initState() {
    super.initState();
    controller.getEmployeeList();
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
        child: controller.isEditor.value
            ? AddEditorEmployee(controller: controller)
            : EmployeeTableList(controller: controller),
      ),
    );
  }
}
