import 'dart:convert';

import 'package:flutter_pc_manager/app/modules/dish_manager/models/dish_dto_model.dart';

DishVo dishVoFromJson(String str) => DishVo.fromJson(json.decode(str));

String dishVoToJson(DishVo data) => json.encode(data.toJson());

class DishVo {
  int total;
  List<DishItem> records;

  DishVo({
    required this.total,
    required this.records,
  });

  factory DishVo.fromJson(Map<String, dynamic> json) => DishVo(
        total: json["total"],
        records: List<DishItem>.from(
            json["records"].map((x) => DishItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
      };
}

class DishItem {
  int id;
  String name;
  int categoryId;
  double price;
  String image;
  String description;
  int status;
  String updateTime;
  dynamic categoryName;
  List<Flavor> flavors;

  DishItem({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.price,
    required this.image,
    required this.description,
    required this.status,
    required this.updateTime,
    required this.categoryName,
    required this.flavors,
  });

  factory DishItem.fromJson(Map<String, dynamic> json) => DishItem(
        id: json["id"],
        name: json["name"],
        categoryId: json["categoryId"],
        price: json["price"],
        image: json["image"],
        description: json["description"],
        status: json["status"],
        updateTime: json["updateTime"],
        categoryName: json["categoryName"],
        flavors: List<Flavor>.from(json["flavors"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "categoryId": categoryId,
        "price": price,
        "image": image,
        "description": description,
        "status": status,
        "updateTime": updateTime,
        "categoryName": categoryName,
        "flavors": List<Flavor>.from(flavors!.map((x) => x)),
      };
}
