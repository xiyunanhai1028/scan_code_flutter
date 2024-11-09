/*
 * @Author: dfh
 * @Date: 2024-10-15 15:30:12
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/modules/setmeal_manager/controllers/setmeal_manager_controller.dart';
import 'package:flutter_pc_manager/bean/options_model.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../components/button_small_widget.dart';
import '../../../components/icon_button_small_widget.dart';
import '../../../components/select_widget.dart';
import '../models/setmeal_dto_model.dart';

class SetmealSearch extends StatelessWidget {
  final SetmealManagerController controller;

  const SetmealSearch({super.key, required this.controller});

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
                  controller.searchOptions.value.name = v!;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    hintText: '请输入套餐名称'),
              ),
            ),
            Obx(() => SelectWidget(
                  label: "套餐分类",
                  options: controller.categoryOptions.value,
                  callback: (String? v) {
                    controller.searchOptions.value.categoryId = v!;
                  },
                )),
            SelectWidget(
              label: "售卖状态",
              options: dishStatusOptions,
              callback: (String? v) {
                controller.searchOptions.value.status = v!;
              },
            ),
            ButtonSmallWidget(
              text: "查询",
              onPressed: () {
                controller.fetchTableData(
                    searchModel: controller.searchOptions.value);
              },
            ),
          ],
        ),
        IconButtonSmallWidget(
          width: 140,
          label: "新增套餐",
          iconData: Icons.add,
          onPressed: () {
            controller.setmealDTO.value = SetmealDto();
            controller.isAddOrEditor.value = true;
          },
        ),
      ],
    );
  }
}
