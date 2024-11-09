/*
 * @Author: dfh
 * @Date: 2024-11-01 08:37:53
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'dart:convert';

WsModel wsModelFromJson(String str) => WsModel.fromJson(json.decode(str));

String wsModelToJson(WsModel data) => json.encode(data.toJson());

class WsModel {
  int type;
  int orderId;
  String content;

  WsModel({
    required this.type,
    required this.orderId,
    required this.content,
  });

  factory WsModel.fromJson(Map<String, dynamic> json) => WsModel(
        type: json["type"],
        orderId: json["orderId"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "orderId": orderId,
        "content": content,
      };
}
