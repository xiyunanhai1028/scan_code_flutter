/*
 * @Author: dfh
 * @Date: 2024-10-30 17:06:55
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'dart:convert';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  String dateList;
  String orderCountList;
  String validOrderCountList;
  int totalOrderCount;
  int validOrderCount;
  double orderCompletionRate;

  OrderModel({
    required this.dateList,
    required this.orderCountList,
    required this.validOrderCountList,
    required this.totalOrderCount,
    required this.validOrderCount,
    required this.orderCompletionRate,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        dateList: json["dateList"],
        orderCountList: json["orderCountList"],
        validOrderCountList: json["validOrderCountList"],
        totalOrderCount: json["totalOrderCount"],
        validOrderCount: json["validOrderCount"],
        orderCompletionRate: json["orderCompletionRate"],
      );

  Map<String, dynamic> toJson() => {
        "dateList": dateList,
        "orderCountList": orderCountList,
        "validOrderCountList": validOrderCountList,
        "totalOrderCount": totalOrderCount,
        "validOrderCount": validOrderCount,
        "orderCompletionRate": orderCompletionRate,
      };
}
