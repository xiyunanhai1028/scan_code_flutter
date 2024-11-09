/*
 * @Author: dfh
 * @Date: 2024-09-20 17:15:39
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class LeftNavWidget extends StatefulWidget {
  const LeftNavWidget({super.key});

  @override
  State<LeftNavWidget> createState() => _LeftNavWidgetState();
}

class _LeftNavWidgetState extends State<LeftNavWidget> {
  final controller = Get.find<HomeController>();

  Widget _headerWidget() {
    return Container(
      width: double.infinity,
      height: 40,
      padding: const EdgeInsets.only(left: 14),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'images/logo2.png',
            fit: BoxFit.contain,
          ),
          Container(
            margin: const EdgeInsets.only(top: 4, left: 10),
            child: Text(
              controller.shopInfo.value.name ?? '',
              style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _navItem(Map<String, dynamic> item, int i, bool selected) {
    return GestureDetector(
      onTap: () {
        controller.onCurrentNavIndexChange(i);
      },
      child: Container(
        width: double.infinity,
        height: 80,
        padding: const EdgeInsets.fromLTRB(0, 19, 30, 0),
        child: Container(
          padding: const EdgeInsets.only(left: 20),
          width: double.infinity,
          height: 42,
          decoration: BoxDecoration(
              color: selected ? Colors.amber : Colors.transparent,
              borderRadius:
                  const BorderRadius.horizontal(right: Radius.circular(42))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                item['img'],
                size: 24,
                color: selected ? Colors.black : Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                item['label'],
                style: TextStyle(
                  fontSize: selected ? 20 : 16,
                  color: selected ? Colors.black : Colors.white,
                  fontWeight: selected ? FontWeight.w500 : FontWeight.w100,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _listNav() {
    List<Widget> list = [];
    for (int i = 0; i < controller.navList.value.length; i++) {
      list.add(_navItem(controller.navList.value[i], i,
          controller.currentNavIndex.value == i));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          width: 200,
          height: double.infinity,
          color: const Color.fromRGBO(52, 55, 68, 1),
          child: ListView(
            children: [_headerWidget(), ..._listNav()],
          ),
        ));
  }
}
