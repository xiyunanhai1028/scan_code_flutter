/*
 * @Author: dfh
 * @Date: 2024-10-15 10:13:41
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/modules/order_manager/models/order_manager_model.dart';
import 'package:flutter_pc_manager/app/modules/order_manager/provider/order_manager_provider.dart';
import 'package:get/get.dart';

import '../../../../bean/search_model.dart';
import '../../../../network/http_options.dart';
import '../../../../utils/socket-utils.dart';
import '../../../components/default_dialog_widget.dart';
import '../models/ws_model.dart';

class OrderManagerController extends GetxController {
  final OrderManagerProvider _provider = OrderManagerProvider();
  final total = 0.obs;
  final orderList = Rx<List<OrderItem>>([]);
  //搜索数据
  final searchOptions = SearchModel(page: 1, pageSize: 10).obs;

  final player = AudioPlayer();

  // @override
  // void onInit() {
  //   super.onInit();
  //   print('OrderManagerController init------------>');

  // }

  void fetchTableData() async {
    try {
      dynamic result = await _provider.fetchOrderList(searchOptions.value);
      int code = result['code'];
      if (code == 1) {
        OrderVo data = OrderVo.fromJson(result['data']);
        print(data.toJson());
        total.value = data.total;
        orderList.value = data.records;
      } else {
        String msg = result['msg'];
        Get.snackbar('错误', msg);
      }
    } catch (e) {
      dynamic error = e;
      Get.snackbar('错误', error.message ?? '网络异常');
    }
  }

  void updateOrdersStatus(BuildContext context, int status, String number) {
    // //  1排队 2做餐 3出餐 4完成 5取消 6已退款
    showDialog(
      context: context,
      builder: (context) => DefaultDialogWidget(
        width: 340,
        height: 220,
        title: '提示',
        content: status == 1 ? '请按真实情况进行接单操作，否则会影响排队人数' : '您确定要出餐吗？',
        onConfirm: () async {
          try {
            dynamic result = await _provider.updateOrder(status + 1, number);
            int code = result['code'];
            Get.back();
            if (code == 1) {
              fetchTableData();
            } else {
              String msg = result['msg'];
              Get.snackbar('错误', msg);
            }
          } catch (e) {
            dynamic error = e;
            Get.snackbar('错误', error.message ?? '网络异常');
          }
        },
        onCancel: () {
          Get.back();
        },
      ),
    );
  }

  void websocketListener() {
    int clientId = Random().nextInt(10000);
    // if(SocketUtils().)
    if (SocketUtils().channel != null) {
      print('已经初始化过啦!');
      return;
    }
    SocketUtils().initSocket('${HttpOptions.WEB_SCOKET_URL}/$clientId',
        (event) {
      WsModel wsData = wsModelFromJson(event);
      if (wsData.type == 1) {
        //下单
        payAudio('preview.mp3');
        showWsTips(wsData.content);
        OrderManagerController orderController =
            Get.find<OrderManagerController>();
        orderController.fetchTableData();
      } else if (wsData.type == 2) {
        //支付成
        payAudio('paysuccess.mp3');
      } else if (wsData.type == 3) {
        //催单
        payAudio('reminder.mp3');
        showWsTips(wsData.content);
      }
    });
  }

  //音频播放
  void payAudio(String path) {
    player.play(AssetSource(path));
  }

  //显示提示
  void showWsTips(String content) {
    Get.defaultDialog(
        title: '订单提醒',
        titlePadding: const EdgeInsets.symmetric(vertical: 20.0),
        content: Container(
          width: 200,
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            '您用一条信息的订单,请注意查收!',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.orange[400],
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
        ),
        confirm: GestureDetector(
          onTap: () {
            Get.back();
            fetchTableData();
          },
          child: Container(
            width: 180,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(20)),
            child: const Center(
              child: Text(
                '确定',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
          ),
        ));
    // Get.snackbar(
    //   "订单提醒",
    //   content,
    //   duration: const Duration(seconds: 6),
    //   icon: Icon(
    //     Icons.tips_and_updates,
    //     color: Colors.yellow[600],
    //   ),
    // );
  }
}
