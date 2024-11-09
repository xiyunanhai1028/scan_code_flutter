/*
 * @Author: dfh
 * @Date: 2024-10-09 07:32:00
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    int? id;
    int? role;
    String? username;
    String? name;
    String? token;

    LoginModel({
        this.id,
        this.role,
        this.username,
        this.name,
        this.token,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        id: json["id"],
        role: json["role"],
        username: json["username"],
        name: json["name"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "role": role,
        "username": username,
        "name": name,
        "token": token,
    };
}