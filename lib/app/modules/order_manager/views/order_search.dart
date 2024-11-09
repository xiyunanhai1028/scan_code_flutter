/*
 * @Author: dfh
 * @Date: 2024-10-15 17:16:38
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/config/GlobalColor.dart';

import '../../../components/icon_button_small_widget.dart';
import '../controllers/order_manager_controller.dart';

class OrderSeach extends StatefulWidget {
  final OrderManagerController controller;
  const OrderSeach({super.key, required this.controller});

  @override
  State<OrderSeach> createState() => _OrderSeachState();
}

class _OrderSeachState extends State<OrderSeach> {
  late var currentIndex = 0;

  List<Widget> getNavWidget() {
    //1排队 2做餐 3出餐 4已完成 5已取消 6已退款 7已评论
    List<String> list = ['全部订单', '排队中', '做菜中', '出餐中', '已完成', '已取消', '已退款'];
    List<Widget> widgets = [];
    for (int i = 0; i < list.length; i++) {
      widgets.add(
        GestureDetector(
          onTap: () {
            setState(() {
              currentIndex = i;
              widget.controller.searchOptions.value.status = '$i';
              widget.controller.fetchTableData();
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
                color:
                    currentIndex == i ? GlobalColor.primaryColor : Colors.white,
                border: Border.all(
                    color: currentIndex == i
                        ? GlobalColor.primaryColor
                        : const Color.fromARGB(221, 184, 182, 182),
                    width: 1)),
            child: Text(
              list[i],
              style: TextStyle(
                  fontSize: 14,
                  color: currentIndex == i ? Colors.white : Colors.black),
            ),
          ),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ...getNavWidget(),
            Container(
              width: 250,
              height: 40,
              margin: const EdgeInsets.only(left: 30),
              child: TextField(
                onChanged: (v) {
                  if (v.isNotEmpty) {
                    widget.controller.searchOptions.value.number =
                        int.parse(v!);
                  } else {
                    widget.controller.searchOptions.value.number = null;
                  }
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    hintText: '请输入订单号'),
              ),
            ),
          ],
        ),
        IconButtonSmallWidget(
          width: 140,
          label: "搜索",
          iconData: Icons.search,
          onPressed: () {
            widget.controller.fetchTableData();
          },
        ),
      ],
    );
  }
}
