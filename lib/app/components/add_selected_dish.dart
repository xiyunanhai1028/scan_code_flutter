/*
 * @Author: dfh
 * @Date: 2024-10-22 08:13:21
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/components/icon_button_small_widget.dart';
import 'package:flutter_pc_manager/app/modules/setmeal_manager/controllers/setmeal_manager_controller.dart';
import 'package:flutter_pc_manager/config/GlobalColor.dart';

import '../modules/setmeal_manager/models/setmeal_dto_model.dart';
import 'add_dish_dialog.dart';

class AddSelectedDish extends StatefulWidget {
  final SetmealManagerController controller;
  const AddSelectedDish({super.key, required this.controller});

  @override
  State<AddSelectedDish> createState() => _AddSelectedDishState();
}

class _AddSelectedDishState extends State<AddSelectedDish> {
  Map<int, SetmealDish> selectedSetmealDish = {};

  @override
  void initState() {
    super.initState();
    Map<int, SetmealDish> initialState = {};
    [...?widget.controller.setmealDTO.value.setmealDishes].forEach((element) {
      int id = element.dishId != null ? element.dishId! : element.setmealId!;
      initialState[id] = element;
    });
    setState(() {
      selectedSetmealDish = initialState;
    });
  }

  void setSetmealDish() {
    List<SetmealDish> list = [];
    for (SetmealDish element in selectedSetmealDish.values) {
      list.add(element);
    }
    widget.controller.setmealDTO.value.setmealDishes = list;
  }

  Widget _getHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButtonSmallWidget(
          label: "添加菜品",
          iconData: Icons.add,
          width: 160,
          onPressed: () {
            showDialog(
              context: context,
              builder: (contetx) => AddDishDialog(
                categoryAll: widget.controller.categoryAll.value,
                selectedSetmealDish: selectedSetmealDish,
                callback: (Map<int, SetmealDish> data) {
                  setState(() {
                    selectedSetmealDish = data;
                    setSetmealDish();
                  });
                },
              ),
            );
          },
        ),
        Text.rich(
          TextSpan(children: [
            const TextSpan(
                text: '已选（',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
            TextSpan(
              text: '${selectedSetmealDish.keys.length}',
              style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            const TextSpan(
                text: '）个',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
          ]),
        ),
      ],
    );
  }

  List<DataColumn> _getDataColumn() {
    return ['名称', '原价', '份数', '操作']
        .map(
          (label) => DataColumn(
            label: Expanded(
              flex: 1,
              child: Text(
                label,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
          ),
        )
        .toList();
  }

  Widget _addOrMinus(int key, SetmealDish item) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              if (item.copies == 1) {
                selectedSetmealDish.remove(key);
                setSetmealDish();
              } else {
                selectedSetmealDish[key] = SetmealDish(
                    dishId: item.dishId,
                    name: item.name,
                    price: item.price,
                    copies: item.copies! + 1,
                    setmealId: item.setmealId);
                setSetmealDish();
              }
            });
          },
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.orange),
                color: Colors.orange.withOpacity(0.3)),
            child: const Center(
              child: Text(
                '-',
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ),
          ),
        ),
        Container(
          width: 50,
          height: 30,
          decoration: const BoxDecoration(
              border: Border.symmetric(
                  horizontal: BorderSide(color: Colors.orange))),
          child: Center(
            child: Text(
              '${item.copies}',
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              selectedSetmealDish[key] = SetmealDish(
                  dishId: item.dishId,
                  name: item.name,
                  price: item.price,
                  copies: item.copies! + 1,
                  setmealId: item.setmealId);
              setSetmealDish();
            });
          },
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.orange),
                color: Colors.orange.withOpacity(0.3)),
            child: const Center(
              child: Text(
                '+',
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<DataRow> _getDataRow() {
    List<DataRow> list = [];
    selectedSetmealDish.forEach((key, value) {
      list.add(DataRow(cells: [
        DataCell(Text(value.name!)),
        DataCell(Text('${value.price}')),
        DataCell(_addOrMinus(key, value)),
        DataCell(GestureDetector(
          onTap: () {
            setState(() {
              selectedSetmealDish.remove(key);
              setSetmealDish();
            });
          },
          child: const Text(
            '删除',
            style: TextStyle(color: Colors.red),
          ),
        )),
      ]));
    });
    return list;
  }

  Widget _tableUI() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      child: DataTable(
        border: TableBorder.symmetric(
            outside: const BorderSide(color: GlobalColor.bgColor)),
        columns: _getDataColumn(),
        rows: _getDataRow(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.star,
          color: Colors.red,
          size: 12,
        ),
        const Text(
          "套餐菜品:",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
          width: 820,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
              color: GlobalColor.bgColor.withOpacity(0.9),
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [_getHeader(context), _tableUI()],
          ),
        ),
      ],
    );
  }
}
