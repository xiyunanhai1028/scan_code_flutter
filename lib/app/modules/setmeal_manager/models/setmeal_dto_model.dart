/*
 * @Author: dfh
 * @Date: 2024-10-21 11:01:42
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'dart:convert';

SetmealDto setmealDtoFromJson(String str) =>
    SetmealDto.fromJson(json.decode(str));

String setmealDtoToJson(SetmealDto data) => json.encode(data.toJson());

class SetmealDto {
  int? categoryId;
  String? description;
  int? id;
  String? image;
  String? name;
  double? price;
  List<SetmealDish>? setmealDishes;
  int? status;

  SetmealDto({
    this.categoryId,
    this.description,
    this.id,
    this.image,
    this.name,
    this.price,
    this.setmealDishes,
    this.status,
  });

  factory SetmealDto.fromJson(Map<String, dynamic> json) => SetmealDto(
        categoryId: json["categoryId"],
        description: json["description"],
        id: json["id"],
        image: json["image"],
        name: json["name"],
        price: json["price"],
        setmealDishes: List<SetmealDish>.from(
            json["setmealDishes"].map((x) => SetmealDish.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "description": description,
        "id": id,
        "image": image,
        "name": name,
        "price": price,
        "setmealDishes":
            List<dynamic>.from(setmealDishes!.map((x) => x.toJson())),
        "status": status,
      };
}

class SetmealDish {
  int? copies;
  int? dishId;
  int? id;
  String? name;
  double? price;
  int? setmealId;

  SetmealDish({
    this.copies,
    this.dishId,
    this.id,
    this.name,
    this.price,
    this.setmealId,
  });

  factory SetmealDish.fromJson(Map<String, dynamic> json) => SetmealDish(
        copies: json["copies"],
        dishId: json["dishId"],
        id: json["id"],
        name: json["name"],
        price: json["price"],
        setmealId: json["setmealId"],
      );

  Map<String, dynamic> toJson() => {
        "copies": copies,
        "dishId": dishId,
        "id": id,
        "name": name,
        "price": price,
        "setmealId": setmealId,
      };
}
