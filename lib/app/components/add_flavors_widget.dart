/*
 * @Author: dfh
 * @Date: 2024-10-20 01:40:41
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/components/icon_button_small_widget.dart';
import 'package:flutter_pc_manager/app/components/select_widget.dart';
import 'package:flutter_pc_manager/bean/options_model.dart';
import 'package:flutter_pc_manager/config/GlobalColor.dart';

import '../modules/dish_manager/models/dish_dto_model.dart';

class AddFlavorWidget extends StatefulWidget {
  final Function callback;
  final List<Flavor>? initialFlavors;
  const AddFlavorWidget(
      {super.key, required this.callback, this.initialFlavors});

  @override
  State<AddFlavorWidget> createState() => _AddFlavorWidgetState();
}

class _AddFlavorWidgetState extends State<AddFlavorWidget> {
  Map<String, List<String>> dishFlavor = {
    "甜味": ['无糖', '少糖', '半糖', '多糖', '全糖'],
    "温度": ['热饮', '常温', '去冰', '少冰', '多冰'],
    "忌口": ['不要葱', '不要蒜', '不要香菜', '不要辣'],
    "辣度": ['不辣', '微辣', '中辣', '重辣'],
  };

  List<OptionsBean> options = [
    OptionsBean(value: "甜味", label: "甜味"),
    OptionsBean(value: "温度", label: "温度"),
    OptionsBean(value: "忌口", label: "忌口"),
    OptionsBean(value: "辣度", label: "辣度"),
    // {"value": "甜味", "label": "甜味"},
    // {"value": "温度", "label": "温度"},
    // {"value": "忌口", "label": "忌口"},
    // {"value": "辣度", "label": "辣度"},
  ];

  Map<String, List<String>> selectedDishFlavor = {};

  bool isAdd = false;

  @override
  void initState() {
    if (widget.initialFlavors != null) {
      Map<String, List<String>> flavorsMap = {};
      widget.initialFlavors!.forEach((element) {
        String? name = element.name;
        String? value = element.value;
        List<String> flavors = [];
        json.decode(value!).forEach((e) {
          flavors.add('$e');
        });
        flavorsMap[name!] = flavors;
      });
      setState(() {
        selectedDishFlavor = flavorsMap;
      });
    }
  }

  Widget _getHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '口味名（3个字内）',
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        IconButtonSmallWidget(
          label: "添加口味",
          iconData: Icons.add,
          width: 140,
          onPressed: () {
            setState(() {
              isAdd = true;
            });
          },
        )
      ],
    );
  }

  Widget _flavorsRow(List<String> flavors) {
    List<Widget> list = [];
    for (var item in flavors) {
      list.add(
        Container(
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.orange.withOpacity(0.3),
            border: Border.all(
              color: Colors.orange.withOpacity(0.4),
            ),
          ),
          child: Center(
            child: Text(
              '$item X',
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ),
        ),
      );
    }
    return Row(
      children: list.toList(),
    );
  }

  List<Widget> _showDishFlavor() {
    List<Widget> list = [];
    selectedDishFlavor.forEach((key, value) => list.add(Container(
          margin: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              SelectWidget(
                label: '',
                text: key,
                options: options,
                onlyShow: true,
                callback: (String? txt) {},
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4)),
                  child: (value.isNotEmpty)
                      ? _flavorsRow(value)
                      : const SizedBox(
                          width: 0,
                          height: 0,
                        ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    isAdd = false;
                    selectedDishFlavor.remove(key);
                    widget.callback(selectedDishFlavor);
                  });
                },
                child: const Text(
                  '删除',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        )));
    return list;
  }

  Widget _addDishFlavor() {
    return isAdd
        ? Container(
            margin: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                SelectWidget(
                  label: "口味",
                  options: options,
                  callback: (String? txt) {
                    setState(() {
                      isAdd = false;
                      List<String>? list = dishFlavor[txt];
                      selectedDishFlavor[txt!] = list!;
                      widget.callback(selectedDishFlavor);
                    });
                  },
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4)),
                    child: const SizedBox(
                      width: 0,
                      height: 0,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    isAdd = false;
                  },
                  child: const Text(
                    '删除',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "口味做法:",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        Container(
          width: 820,
          margin: const EdgeInsets.only(left: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
              color: GlobalColor.bgColor.withOpacity(0.3),
              border: Border.all(color: GlobalColor.borderColor),
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [_getHeader(), ..._showDishFlavor(), _addDishFlavor()],
          ),
        )
      ],
    );
  }
}
