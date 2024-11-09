/*
 * @Author: dfh
 * @Date: 2024-10-15 17:08:34
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
/*
 * @Author: dfh
 * @Date: 2024-10-15 17:08:34
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter_pc_manager/app/modules/order_manager/models/refund_dto_model.dart';
import 'package:flutter_pc_manager/network/http.dart';
import 'package:get/get_connect.dart';

import '../../../../bean/search_model.dart';
import '../../../../utils/Utils.dart';

class OrderManagerProvider extends GetConnect {
  //获取表单数据
  Future<dynamic> fetchOrderList(SearchModel? searchModel) async {
    String params = Utils.resoveOptions(searchModel);
    print('请求参数：$params');
    return await Http.get('/order/conditionSearch?$params');
  }

  //状态修改:接单 做菜 出餐
  Future<dynamic> updateOrder(int status, String number) async {
    return await Http.post('/order/status/$status?number=$number');
  }

  //退款操作
  Future<dynamic> refundOrder(RefundDto data) async {
    return await Http.post('/order/refund', data: data);
  }
}
