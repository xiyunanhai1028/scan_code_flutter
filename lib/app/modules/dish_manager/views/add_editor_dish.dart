/*
 * @Author: dfh
 * @Date: 2024-10-20 00:01:25
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/components/add_flavors_widget.dart';
import 'package:flutter_pc_manager/app/components/add_image_widget.dart';
import 'package:flutter_pc_manager/app/components/button_small_widget.dart';
import 'package:flutter_pc_manager/app/components/text_form_field_selected_widget.dart';
import 'package:flutter_pc_manager/app/modules/dish_manager/controllers/dish_manager_controller.dart';
import 'package:flutter_pc_manager/app/modules/dish_manager/models/dish_dto_model.dart';

import '../../../components/text_form_field_widget.dart';

class AddEditorWidget extends StatefulWidget {
  final DishManagerController controller;
  const AddEditorWidget({super.key, required this.controller});

  @override
  State<AddEditorWidget> createState() => _AddEditorWidgetState();
}

class _AddEditorWidgetState extends State<AddEditorWidget> {
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
                    label: '菜品名称',
                    text: widget.controller.dishDTO.value.name ?? '',
                    required: true,
                    onChange: (String v) {
                      widget.controller.dishDTO.value.name = v;
                    },
                  ),
                ),
                SizedBox(
                  width: 440,
                  child: TextFormFieldSelectedWidget(
                    label: "菜品分类",
                    text: widget.controller.dishDTO.value.categoryId != null
                        ? '${widget.controller.dishDTO.value.categoryId}'
                        : '',
                    required: true,
                    options: widget.controller.categoryOptions.value,
                    callback: (String? txt) {
                      widget.controller.dishDTO.value.categoryId =
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
                label: '菜品价格',
                text: widget.controller.dishDTO.value.price != null
                    ? '${widget.controller.dishDTO.value.price}'
                    : '',
                required: true,
                onChange: (String v) {
                  widget.controller.dishDTO.value.price = double.parse(v);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AddFlavorWidget(
              initialFlavors: widget.controller.dishDTO.value.flavors,
              callback: (Map<String, List<String>> mapFlavors) {
                mapFlavors.forEach((key, value) {
                  widget.controller.dishDTO.value.flavors = [
                    Flavor(name: key, value: json.encode(value))
                  ];
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            AddImageWidget(
                label: '菜品',
                initialImage: widget.controller.dishDTO.value.image ?? '',
                callback: (String url) {
                  widget.controller.dishDTO.value.image = url;
                }),
            const SizedBox(
              height: 20,
            ),
            TextFormFieldWidget(
              label: '菜品描述',
              text: widget.controller.dishDTO.value.description ?? '',
              maxLines: 4,
              required: true,
              onChange: (String v) {
                widget.controller.dishDTO.value.description = v;
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
                      widget.controller.saveOrUpdateDish();
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
