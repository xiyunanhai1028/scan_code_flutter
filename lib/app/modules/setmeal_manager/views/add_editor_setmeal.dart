/*
 * @Author: dfh
 * @Date: 2024-10-21 10:46:59
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/components/add_selected_dish.dart';
import 'package:flutter_pc_manager/app/modules/setmeal_manager/controllers/setmeal_manager_controller.dart';
import 'package:get/get.dart';

import '../../../components/add_image_widget.dart';
import '../../../components/button_small_widget.dart';
import '../../../components/text_form_field_selected_widget.dart';
import '../../../components/text_form_field_widget.dart';

class AddEditorSetmeal extends StatefulWidget {
  final SetmealManagerController controller;

  const AddEditorSetmeal({super.key, required this.controller});

  @override
  State<AddEditorSetmeal> createState() => _AddEditorSetmealState();
}

class _AddEditorSetmealState extends State<AddEditorSetmeal> {
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 20),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 440,
                  child: TextFormFieldWidget(
                    label: '套餐名称',
                    text: widget.controller.setmealDTO.value.name ?? '',
                    required: true,
                    onChange: (String v) {
                      widget.controller.setmealDTO.value.name = v;
                    },
                  ),
                ),
                SizedBox(
                  width: 440,
                  child: TextFormFieldSelectedWidget(
                    label: "套餐分类",
                    text: widget.controller.setmealDTO.value.categoryId != null
                        ? '${widget.controller.setmealDTO.value.categoryId}'
                        : '',
                    required: true,
                    options: widget.controller.categoryOptions.value,
                    callback: (String? txt) {
                      widget.controller.setmealDTO.value.categoryId =
                          int.parse(txt!);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 440,
              child: TextFormFieldWidget(
                label: '套餐价格',
                text: widget.controller.setmealDTO.value.price != null
                    ? '${widget.controller.setmealDTO.value.price}'
                    : '',
                required: true,
                onChange: (String v) {
                  widget.controller.setmealDTO.value.price = double.parse(v);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AddSelectedDish(controller: widget.controller),
            const SizedBox(
              height: 20,
            ),
            AddImageWidget(
                label: '套餐',
                initialImage: widget.controller.setmealDTO.value.image ?? '',
                callback: (String url) {
                  widget.controller.setmealDTO.value.image = url;
                }),
            const SizedBox(
              height: 20,
            ),
            TextFormFieldWidget(
              label: '套餐描述',
              text: widget.controller.setmealDTO.value.description ?? '',
              maxLines: 4,
              required: true,
              onChange: (String v) {
                widget.controller.setmealDTO.value.description = v;
              },
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonSmallWidget(
                  text: '取消',
                  backgroundColor: Colors.grey,
                  color: Colors.white,
                  onPressed: () {
                    widget.controller.isAddOrEditor.value = false;
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                ButtonSmallWidget(
                  text: '确定',
                  onPressed: () {
                    if ((_formKey.currentState as FormState).validate()) {
                      if (widget.controller.setmealDTO.value.setmealDishes ==
                              null ||
                          widget.controller.setmealDTO.value.setmealDishes!
                              .isEmpty) {
                        Get.snackbar('提示', '请天假菜品');
                      } else {
                        widget.controller.saveOrUpdateDish();
                      }
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
