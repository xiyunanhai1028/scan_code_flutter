/*
 * @Author: dfh
 * @Date: 2024-10-15 10:13:14
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
/*
 * @Author: dfh
 * @Date: 2024-10-15 10:13:14
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
/*
 * @Author: dfh
 * @Date: 2024-10-15 10:13:14
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter_pc_manager/app/modules/statistics_manager/models/order_model.dart';
import 'package:flutter_pc_manager/app/modules/statistics_manager/models/top10_model.dart';
import 'package:flutter_pc_manager/app/modules/statistics_manager/models/turnover_model.dart';
import 'package:flutter_pc_manager/app/modules/statistics_manager/models/user_model.dart';
import 'package:flutter_pc_manager/app/modules/statistics_manager/provider/statistics_manger_provider.dart';
import 'package:get/get.dart';

class StatisticsManagerController extends GetxController {
  final StatisticsManagerProvider _provider = StatisticsManagerProvider();
  final navIndex = 0.obs;
  //营业额相关数据
  final turnoverData = TurnoverVo(dateList: '', turnoverList: '').obs;
  final turnoverX = Rx<List<String>>([]);
  final turnoverY = Rx<List<String>>([]);

  //用户相关数据
  final userX = Rx<List<String>>([]);
  final totalUserY = Rx<List<String>>([]);
  final newUserY = Rx<List<String>>([]);

  //订单相关数据
  final orderX = Rx<List<String>>([]);
  final totalOrderY = Rx<List<String>>([]);
  final validOrderY = Rx<List<String>>([]);
  final totalOrder = 0.obs; //总订单数
  final validOrder = 0.obs; //有效订单数
  final orderCompleteRate = 0.0.obs; //订单完成率

  //top10
  final top10X = Rx<List<String>>([]);
  final top10Y = Rx<List<String>>([]);

  void fetchTurnoverData(int type) async {
    try {
      dynamic result = await _provider.fetchTurnoverList(type);
      int code = result['code'];
      if (code == 1) {
        TurnoverVo data = TurnoverVo.fromJson(result['data']);
        turnoverData.value = data;
        turnoverX.value = data.dateList.split(',');
        turnoverY.value = data.turnoverList.split(',');
      } else {
        String msg = result['msg'];
        Get.snackbar('错误', msg);
      }
    } catch (e) {
      dynamic error = e;
      Get.snackbar('错误', error.message ?? '网络异常');
    }
  }

  void fetchUserData(int type) async {
    try {
      dynamic result = await _provider.fetchUserList(type);

      int code = result['code'];
      if (code == 1) {
        UserVo data = UserVo.fromJson(result['data']);
        userX.value = data.dateList.split(',');
        totalUserY.value = data.totalUserList.split(',');
        newUserY.value = data.newUserList.split(',');
      } else {
        String msg = result['msg'];
        Get.snackbar('错误', msg);
      }
    } catch (e) {
      dynamic error = e;
      Get.snackbar('错误', error.message ?? '网络异常');
    }
  }

  void fetchOrderData(int type) async {
    try {
      dynamic result = await _provider.fetchOrderList(type);

      int code = result['code'];
      if (code == 1) {
        print('data-->${result['data']}');
        OrderModel data = OrderModel.fromJson(result['data']);
        totalOrderY.value = data.orderCountList.split(',');
        validOrderY.value = data.validOrderCountList.split(',');
        orderX.value = data.dateList.split(',');
        totalOrder.value = data.totalOrderCount;
        validOrder.value = data.validOrderCount;
        orderCompleteRate.value = data.orderCompletionRate;
      } else {
        String msg = result['msg'];
        Get.snackbar('错误', msg);
      }
    } catch (e) {
      dynamic error = e;
      Get.snackbar('错误', error.message ?? '网络异常');
    }
  }

  void fetchTop10Data(int type) async {
    try {
      dynamic result = await _provider.fetchTop10List(type);

      int code = result['code'];
      if (code == 1) {
        Top10Model data = Top10Model.fromJson(result['data']);
        if (data.nameList.isNotEmpty) {
          top10X.value = data.nameList.split(',');
          top10Y.value = data.numberList.split(',');
        }
      } else {
        String msg = result['msg'];
        Get.snackbar('错误', msg);
      }
    } catch (e) {
      dynamic error = e;
      Get.snackbar('错误', error.message ?? '网络异常');
    }
  }
}
