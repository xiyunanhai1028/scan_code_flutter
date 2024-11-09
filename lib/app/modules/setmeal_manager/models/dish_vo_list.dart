/*
 * @Author: dfh
 * @Date: 2024-10-21 15:56:29
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'dart:convert';

List<DishVoList> dishVoListFromJson(String str) =>
    List<DishVoList>.from(json.decode(str).map((x) => DishVoList.fromJson(x)));

String dishVoListToJson(List<DishVoList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DishVoList {
  int id;
  String name;
  int categoryId;
  double price;
  String image;
  String description;
  int status;
  String createTime;
  String updateTime;
  int createUser;
  int updateUser;

  DishVoList({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.price,
    required this.image,
    required this.description,
    required this.status,
    required this.createTime,
    required this.updateTime,
    required this.createUser,
    required this.updateUser,
  });

  factory DishVoList.fromJson(Map<String, dynamic> json) => DishVoList(
        id: json["id"],
        name: json["name"],
        categoryId: json["categoryId"],
        price: json["price"],
        image: json["image"],
        description: json["description"],
        status: json["status"],
        createTime: json["createTime"],
        updateTime: json["updateTime"],
        createUser: json["createUser"],
        updateUser: json["updateUser"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "categoryId": categoryId,
        "price": price,
        "image": image,
        "description": description,
        "status": status,
        "createTime": createTime,
        "updateTime": updateTime,
        "createUser": createUser,
        "updateUser": updateUser,
      };
}
