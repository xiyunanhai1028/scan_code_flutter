/*
 * @Author: dfh
 * @Date: 2024-10-15 10:12:38
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/components/button_small_widget.dart';
import 'package:flutter_pc_manager/app/components/start_and_end_time_selected.dart';

import 'package:get/get.dart';

import '../../../components/text_form_field_widget.dart';
import '../controllers/shop_manager_controller.dart';

class ShopManagerView extends GetView<ShopManagerController> {
  const ShopManagerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      const TextFormFieldWidget(
                        label: "店铺名称",
                        text: "饭当家",
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      const TextFormFieldWidget(
                        label: "店铺位置",
                        text: "江苏省昆山市玉山镇",
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      StartAndEndTimeSelected(),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ButtonSmallWidget(
                            text: '停业整顿',
                            width: 180,
                            backgroundColor: Colors.grey,
                            onPressed: () {},
                          ),
                          ButtonSmallWidget(
                            text: '开始营业',
                            width: 180,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      //当前餐厅处于营业状态，自动接收任何订单，可点击打烊进入店铺打烊状态。
                      Card(
                        shadowColor: Colors.black,
                        elevation: 4,
                        child: Container(
                          margin: const EdgeInsets.all(14),
                          child: const Text(
                            '当前餐厅处于打烊状态，仅接受营业时间内的预定订单，可点击营业中手动恢复营业状态。',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                            ),
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
            const Expanded(
              flex: 1,
              child: TextFormFieldWidget(
                label: '简介',
                maxLines: 7,
                readOnly: true,
                text: "饭当家餐厅是饭当家独立的品牌，定位“大众话的没事点餐”，旨为顾客打造专业美食",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                ButtonSmallWidget(text: '编辑'),
                SizedBox(
                  width: 10,
                ),
                ButtonSmallWidget(
                  text: '保存',
                  backgroundColor: Colors.grey,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
