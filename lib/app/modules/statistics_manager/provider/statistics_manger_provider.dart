/*
 * @Author: dfh
 * @Date: 2024-10-16 08:32:35
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter_pc_manager/network/http.dart';
import 'package:get/get_connect.dart';

class StatisticsManagerProvider extends GetConnect {
  //获取营业额数据
  Future<dynamic> fetchTurnoverList(int type) async {
    return await Http.get('/report/turnoverStatistics?type=$type');
  }

  //获取用户统计
  Future<dynamic> fetchUserList(int type) async {
    return await Http.get('/report/userStatistics?type=$type');
  }

  //订单统计
  Future<dynamic> fetchOrderList(int type) async {
    return await Http.get('/report/ordersStatistics?type=$type');
  }

  //销量排名top10统计
  Future<dynamic> fetchTop10List(int type) async {
    return await Http.get('/report/top10?type=$type');
  }
}
