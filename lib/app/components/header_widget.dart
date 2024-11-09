/*
 * @Author: dfh
 * @Date: 2024-09-20 17:15:39
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/components/default_dialog_widget.dart';
import 'package:flutter_pc_manager/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_pc_manager/config/GlobalColor.dart';
import 'package:flutter_pc_manager/utils/shared_preferences_utils.dart';
import 'package:get/get.dart';
import '../../utils/nau_icon.dart';
import '../routes/app_pages.dart';

class HeaderWidget extends StatefulWidget {
  final int currentNavIndex;

  final String username;
  final HomeController controller;

  const HeaderWidget(
      {super.key,
      required this.currentNavIndex,
      required this.username,
      required this.controller});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  List<String> navItem = [
    '员工管理',
    '分类管理',
    '菜单管理',
    '套餐管理',
    '订单管理',
    '统计管理',
    '店铺管理',
  ];

  void loginOut() {
    showDialog(
        context: context,
        builder: (context) => DefaultDialogWidget(
              title: '退出登录',
              content: '您确定要退出登录吗？',
              onCancel: () {
                Get.back();
              },
              onConfirm: () async {
                Get.back();
                await SharedPreferenceUtils.saveData("token", "");
                await SharedPreferenceUtils.saveData("role", "");
                await SharedPreferenceUtils.saveData("username", "");
                Get.offAndToNamed(Routes.LOGIN);
              },
            ));
  }

  //更新店铺状态
  void updateShopStatusDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: 380,
          height: 400,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Card(
                color: widget.controller.shopInfo.value.status == 1
                    ? GlobalColor.primaryColor
                    : GlobalColor.bgColor,
                shadowColor: Colors.black,
                elevation: 2,
                child: ListTile(
                  onTap: () {
                    widget.controller.updateShopStatus();
                    Get.back();
                  },
                  title: const Text(
                    '开业',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        letterSpacing: 5,
                        height: 2,
                        fontWeight: FontWeight.w600),
                  ),
                  subtitle: Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: const Text(
                      '当前餐厅处于营业状态，自动接收任何订单，可点击打烊进入店铺打烊状态。',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w500,
                          height: 1.6),
                    ),
                  ),
                  selectedColor: Colors.yellow,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Card(
                color: widget.controller.shopInfo.value.status == 0
                    ? GlobalColor.primaryColor
                    : GlobalColor.bgColor,
                shadowColor: Colors.black,
                elevation: 2,
                child: ListTile(
                  onTap: () {
                    widget.controller.updateShopStatus();
                    Get.back();
                  },
                  title: const Text(
                    '打样',
                    style: TextStyle(
                        fontSize: 20,
                        height: 2.0,
                        color: Colors.black,
                        letterSpacing: 5,
                        fontWeight: FontWeight.w600),
                  ),
                  subtitle: Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: const Text(
                      '当前餐厅处于打烊状态，仅接受营业时间内的就餐，可点击营业中手动恢复营业状态。',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          height: 1.6,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      padding: const EdgeInsets.only(left: 20, right: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 21, 41, 0.08),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  navItem[widget.currentNavIndex],
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () {
                    updateShopStatusDialog();
                  },
                  child: Obx(() => Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 10),
                        margin: const EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: widget.controller.shopInfo.value.status == 1
                                ? GlobalColor.primaryColor
                                : Colors.red),
                        child: Text(
                          widget.controller.shopInfo.value.status == 1
                              ? '营业中'
                              : '打样中',
                          style: TextStyle(
                              color:
                                  widget.controller.shopInfo.value.status == 1
                                      ? Colors.black
                                      : Colors.white,
                              fontSize: 14),
                        ),
                      )),
                )
              ],
            ),
          ),
          Text(
            widget.username,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            icon: const Icon(NauIcon.iconClose),
            onPressed: () {
              loginOut();
            },
          )
        ],
      ),
    );
  }
}
