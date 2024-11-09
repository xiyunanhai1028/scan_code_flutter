/*
 * @Author: dfh
 * @Date: 2024-10-09 09:49:58
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
/*
 * @Author: dfh
 * @Date: 2024-10-09 09:49:58
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/modules/category_manager/views/category_table.dart';

import 'package:get/get.dart';

import '../controllers/category_manager_controller.dart';

class CategoryManagerView extends StatefulWidget {
  const CategoryManagerView({super.key});

  @override
  State<CategoryManagerView> createState() => _CategoryManagerViewState();
}

class _CategoryManagerViewState extends State<CategoryManagerView> {
  final _controller = CategoryManagerController();

  @override
  void initState() {
    super.initState();
    _controller.fetchCategoryList();
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
      child: CategoryTable(
        controller: _controller,
      ),
    );
  }
}
