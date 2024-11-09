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
import '../controllers/statistics_manager_controller.dart';

class StatisticsSearch extends StatefulWidget {
  final StatisticsManagerController controller;
  const StatisticsSearch({super.key, required this.controller});

  @override
  State<StatisticsSearch> createState() => _OrderSeachState();
}

class _OrderSeachState extends State<StatisticsSearch> {
  late var currentIndex = 0;

  List<Widget> getNavWidget() {
    List<String> list = ['本周', '本月', '3个月'];
    List<Widget> widgets = [];
    for (int i = 0; i < list.length; i++) {
      widgets.add(
        GestureDetector(
          onTap: () {
            setState(() {
              currentIndex = i;
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
          ],
        ),
        IconButtonSmallWidget(
          width: 140,
          label: "搜索",
          iconData: Icons.search,
          onPressed: () {
            widget.controller.fetchTurnoverData(currentIndex);
            widget.controller.fetchUserData(currentIndex);
            widget.controller.fetchOrderData(currentIndex);
            widget.controller.fetchTop10Data(currentIndex);
          },
        ),
      ],
    );
  }
}
