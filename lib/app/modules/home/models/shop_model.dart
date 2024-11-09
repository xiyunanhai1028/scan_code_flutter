/*
 * @Author: dfh
 * @Date: 2024-10-23 17:49:00
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'dart:convert';

ShopModel shopModelFromJson(String str) => ShopModel.fromJson(json.decode(str));

String shopModelToJson(ShopModel data) => json.encode(data.toJson());

class ShopModel {
  int? id;
  String? name;
  String? address;
  int? status;
  String? image;
  String? description;
  String? beginTime;
  String? endTime;

  ShopModel({
    this.id,
    this.name,
    this.address,
    this.status,
    this.image,
    this.description,
    this.beginTime,
    this.endTime,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        status: json["status"],
        image: json["image"],
        description: json["description"],
        beginTime: json["beginTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "status": status,
        "image": image,
        "description": description,
        "beginTime": beginTime,
        "endTime": endTime,
      };
}
