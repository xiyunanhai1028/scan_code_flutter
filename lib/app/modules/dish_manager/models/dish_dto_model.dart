/*
 * @Author: dfh
 * @Date: 2024-10-20 23:14:36
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'dart:convert';

DishDto dishDtoFromJson(String str) => DishDto.fromJson(json.decode(str));

String dishDtoToJson(DishDto data) => json.encode(data.toJson());

class DishDto {
  int? categoryId;
  String? description;
  List<Flavor>? flavors;
  int? id;
  String? image;
  String? name;
  double? price;
  int? status;

  DishDto({
    this.categoryId,
    this.description,
    this.flavors,
    this.id,
    this.image,
    this.name,
    this.price,
    this.status,
  });

  factory DishDto.fromJson(Map<String, dynamic> json) => DishDto(
        categoryId: json["categoryId"],
        description: json["description"],
        flavors:
            List<Flavor>.from(json["flavors"].map((x) => Flavor.fromJson(x))),
        id: json["id"],
        image: json["image"],
        name: json["name"],
        price: json["price"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "description": description,
        "flavors": List<dynamic>.from(flavors!.map((x) => x.toJson())),
        "id": id,
        "image": image,
        "name": name,
        "price": price,
        "status": status,
      };
}

class Flavor {
  int? dishId;
  int? id;
  String? name;
  String? value;

  Flavor({
    this.dishId,
    this.id,
    this.name,
    this.value,
  });

  factory Flavor.fromJson(Map<String, dynamic> json) => Flavor(
        dishId: json["dishId"],
        id: json["id"],
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "dishId": dishId,
        "id": id,
        "name": name,
        "value": value,
      };
}
