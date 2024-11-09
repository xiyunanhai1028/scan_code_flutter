/*
 * @Author: dfh
 * @Date: 2024-10-15 10:12:38
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/config/GlobalColor.dart';

import '../../../components/button_small_widget.dart';
import '../../../components/start_and_end_time_selected.dart';
import '../../../components/text_form_field_widget.dart';
import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';

class ShopManagerView extends StatefulWidget {
  const ShopManagerView({super.key});

  @override
  State<ShopManagerView> createState() => _ShopManagerViewState();
}

class _ShopManagerViewState extends State<ShopManagerView> {
  final controller = Get.find<HomeController>();
  bool readOnly = true;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6), color: Colors.white),
        child: Form(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      width: double.infinity,
                      height: 400,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          'https://img.51miz.com/Element/00/59/57/68/da57b0b1_E595768_ff616855.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormFieldWidget(
                          label: "店铺名称",
                          readOnly: readOnly,
                          text: controller.shopInfo.value.name ?? '',
                          onChange: (v) {
                            controller.shopInfo.value.name = v!;
                          },
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        TextFormFieldWidget(
                          label: "店铺位置",
                          readOnly: readOnly,
                          text: controller.shopInfo.value.address ?? '',
                          onChange: (v) {
                            controller.shopInfo.value.address = v!;
                          },
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        StartAndEndTimeSelected(
                          readOnly: readOnly,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ButtonSmallWidget(
                              text: '停业整顿',
                              width: 180,
                              backgroundColor:
                                  controller.shopInfo.value.status == 0
                                      ? GlobalColor.primaryColor
                                      : Colors.grey,
                              onPressed: () {
                                if (!readOnly) {
                                  controller.updateShopStatus();
                                }
                              },
                            ),
                            ButtonSmallWidget(
                              text: '开始营业',
                              backgroundColor:
                                  controller.shopInfo.value.status == 1
                                      ? GlobalColor.primaryColor
                                      : Colors.grey,
                              width: 180,
                              onPressed: () {
                                if (!readOnly) {
                                  controller.updateShopStatus();
                                }
                              },
                            ),
                          ],
                        ),
                        //当前餐厅处于营业状态，自动接收任何订单，可点击打烊进入店铺打烊状态。
                        Card(
                          shadowColor: Colors.black,
                          elevation: 4,
                          child: Container(
                            margin: const EdgeInsets.all(14),
                            child: Text(
                              controller.shopInfo.value.status == 1
                                  ? '当前餐厅处于营业状态，自动接收任何订单，可点击打烊进入店铺打烊状态。'
                                  : '当前餐厅处于打烊状态，仅接受营业时间内的就餐，可点击营业中手动恢复营业状态。',
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  height: 1.6),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                flex: 1,
                child: TextFormFieldWidget(
                  label: '简介',
                  maxLines: 7,
                  readOnly: readOnly,
                  text: controller.shopInfo.value.description ?? '',
                  onChange: (v) {
                    controller.shopInfo.value.description = v!;
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonSmallWidget(
                    text: readOnly ? '编辑' : '保存',
                    onPressed: () {
                      if (!readOnly) {
                        controller.updateShopInfo();
                        setState(() {
                          readOnly = !readOnly;
                        });
                      } else {
                        setState(() {
                          readOnly = !readOnly;
                        });
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
