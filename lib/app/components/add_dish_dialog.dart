/*
 * @Author: dfh
 * @Date: 2024-10-21 14:39:00
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/components/button_small_widget.dart';
import 'package:flutter_pc_manager/config/GlobalColor.dart';
import 'package:get/get.dart';

import '../../network/http.dart';
import '../modules/dish_manager/models/category_options.dart';
import '../modules/setmeal_manager/models/dish_vo_list.dart';
import '../modules/setmeal_manager/models/setmeal_dto_model.dart';

class AddDishDialog extends StatefulWidget {
  final List<CategoryOptions> categoryAll;
  final Function callback;
  final Map<int, SetmealDish> selectedSetmealDish;
  const AddDishDialog(
      {super.key,
      required this.categoryAll,
      required this.callback,
      required this.selectedSetmealDish});

  @override
  State<AddDishDialog> createState() => _AddDishDialogState();
}

class _AddDishDialogState extends State<AddDishDialog> {
  int categoryIndex = 0;
  bool isDish = true;
  List<DishVoList> dishList = [];
  Map<int, SetmealDish> selected = {};

  @override
  void initState() {
    super.initState();
    selected = widget.selectedSetmealDish;
    if (widget.categoryAll.isNotEmpty) {
      fetchDishById(widget.categoryAll[0].id);
    }
  }

  void fetchDishById(int categoryId) async {
    try {
      dynamic result =
          await await Http.get('/dish/list?categoryId=$categoryId');
      int code = result['code'];
      if (code == 1) {
        List<DishVoList> data = dishVoListFromJson(json.encode(result['data']));
        setState(() {
          dishList = data;
        });
      } else {
        String msg = result['msg'];
        Get.snackbar('错误', msg);
      }
    } catch (e) {
      dynamic error = e;
      Get.snackbar('错误', error.message ?? '网络异常');
    }
  }

  List<Widget> _getCategoryList(List<CategoryOptions> data) {
    List<Widget> list = [];
    for (int i = 0; i < data.length; i++) {
      CategoryOptions item = data[i];
      list.add(SizedBox(
        height: 40,
        child: TextButton(
          onPressed: () {
            setState(() {
              isDish = item.type == 1;
              fetchDishById(item.id);
              categoryIndex = i;
            });
          },
          child: Text(
            item.name,
            style: TextStyle(
                color: categoryIndex == i ? Colors.amber[400] : Colors.black),
          ),
        ),
      ));
    }
    return list;
  }

  bool isDishSelected(int id) {
    return selected.keys.contains(id);
  }

  List<Widget> _getDishList(List<DishVoList> data) {
    List<Widget> list = [];
    for (int i = 0; i < data.length; i++) {
      DishVoList item = data[i];
      list.add(GestureDetector(
        onTap: () {
          if (selected.keys.contains(item.id)) {
            setState(() {
              selected.remove(item.id);
            });
          } else {
            setState(() {
              selected[item.id] = SetmealDish(
                  dishId: isDish ? item.id : null,
                  name: item.name,
                  price: item.price,
                  copies: 1,
                  setmealId: isDish ? null : item.id);
            });
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 50,
          child: Row(
            children: [
              Icon(
                isDishSelected(item.id)
                    ? Icons.check_box_outlined
                    : Icons.check_box_outline_blank,
                size: 20,
                color:
                    isDishSelected(item.id) ? Colors.amber[400] : Colors.grey,
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                item.name,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              const Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '在售',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
              Container(
                width: 80,
                alignment: Alignment.centerRight,
                child: Text(
                  '￥${item.price}',
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ));
    }
    return list;
  }

  List<Widget> _getSelectedDish() {
    List<Widget> list = [];
    selected.forEach((key, value) {
      list.add(Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${value.name}',
              style: const TextStyle(color: Colors.black),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  selected.remove(key);
                });
              },
              icon: const Icon(
                Icons.close,
                size: 16,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 800,
        height: 600,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Container(
                    width: 160,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: GlobalColor.bgColor),
                    ),
                    child: ListView(
                        children: _getCategoryList(widget.categoryAll)),
                  ),
                  Container(
                    width: 420,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: GlobalColor.bgColor),
                    ),
                    child: ListView(children: _getDishList(dishList)),
                  ),
                  Container(
                    width: 180,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: GlobalColor.bgColor),
                    ),
                    child: ListView(
                      children: _getSelectedDish(),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonSmallWidget(
                  text: '取消',
                  backgroundColor: Colors.grey,
                  color: Colors.white,
                  onPressed: () {
                    Get.back();
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                ButtonSmallWidget(
                  text: '添加',
                  onPressed: () {
                    Get.back();
                    // List<SetmealDish> data = [];
                    // selected.forEach((key, value) {
                    //   data.add(value);
                    // });
                    widget.callback(selected);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
