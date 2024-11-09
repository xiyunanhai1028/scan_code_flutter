/*
 * @Author: dfh
 * @Date: 2024-10-15 15:45:51
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
// To parse this JSON data, do
//
//     final setmealVo = setmealVoFromJson(jsonString);

import 'dart:convert';

SetmealVo setmealVoFromJson(String str) => SetmealVo.fromJson(json.decode(str));

String setmealVoToJson(SetmealVo data) => json.encode(data.toJson());

class SetmealVo {
    int total;
    List<SetmealItem> records;

    SetmealVo({
        required this.total,
        required this.records,
    });

    factory SetmealVo.fromJson(Map<String, dynamic> json) => SetmealVo(
        total: json["total"],
        records: List<SetmealItem>.from(json["records"].map((x) => SetmealItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
    };
}

class SetmealItem {
    int id;
    int categoryId;
    String name;
    double price;
    int status;
    String description;
    String image;
    String updateTime;
    String categoryName;
    List<dynamic> setmealDishes;

    SetmealItem({
        required this.id,
        required this.categoryId,
        required this.name,
        required this.price,
        required this.status,
        required this.description,
        required this.image,
        required this.updateTime,
        required this.categoryName,
        required this.setmealDishes,
    });

    factory SetmealItem.fromJson(Map<String, dynamic> json) => SetmealItem(
        id: json["id"],
        categoryId: json["categoryId"],
        name: json["name"],
        price: json["price"],
        status: json["status"],
        description: json["description"],
        image: json["image"],
        updateTime: json["updateTime"],
        categoryName: json["categoryName"],
        setmealDishes: List<dynamic>.from(json["setmealDishes"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "categoryId": categoryId,
        "name": name,
        "price": price,
        "status": status,
        "description": description,
        "image": image,
        "updateTime": updateTime,
        "categoryName": categoryName,
        "setmealDishes": List<dynamic>.from(setmealDishes.map((x) => x)),
    };
}
