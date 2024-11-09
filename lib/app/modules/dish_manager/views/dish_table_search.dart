/*
 * @Author: dfh
 * @Date: 2024-10-11 15:23:51
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/modules/dish_manager/controllers/dish_manager_controller.dart';

import '../../../../bean/options_model.dart';
import '../../../../bean/search_model.dart';
import '../../../components/button_small_widget.dart';
import '../../../components/icon_button_small_widget.dart';
import '../../../components/select_widget.dart';

class DishTableSearch extends StatelessWidget {
  final List<OptionsBean> categoryOptions;
  final DishManagerController controller;

  const DishTableSearch(
      {super.key, required this.categoryOptions, required this.controller});

  @override
  Widget build(BuildContext context) {
    //售卖状态：0 停售 1 起售
    List<OptionsBean> dishStatusOptions = [
      OptionsBean(value: '0', label: '停售'),
      OptionsBean(value: '1', label: '起售'),
    ];

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
                onChanged: (v) {
                  //  controller.searchModel.value.name = v!;
                  controller.searchOptions.value.name = v!;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    hintText: '请输入菜品名称'),
              ),
            ),
            SelectWidget(
              label: "菜品分类",
              options: categoryOptions,
              callback: (String? txt) {
                controller.searchOptions.value.categoryId = txt!;
              },
            ),
            SelectWidget(
              label: "售卖状态",
              options: dishStatusOptions,
              callback: (String? txt) {
                controller.searchOptions.value.status = txt!;
              },
            ),
            ButtonSmallWidget(
              text: "查询",
              onPressed: () {
                print('${controller.searchOptions.value.name}');
                print('${controller.searchOptions.value.status}');
                print('${controller.searchOptions.value.categoryId}');
                // onSearch(searchModel);
                controller.fetchTableData(
                    dishSearch: SearchModel(
                        name: controller.searchOptions.value.name,
                        status: controller.searchOptions.value.status,
                        categoryId: controller.searchOptions.value.categoryId));
              },
            ),
          ],
        ),
        IconButtonSmallWidget(
          width: 140,
          label: "新增菜品",
          iconData: Icons.add,
          onPressed: () {
            controller.isAddOrEditor.value = true;
          },
        ),
      ],
    );
  }
}
