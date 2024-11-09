/*
 * @Author: dfh
 * @Date: 2024-10-09 14:57:40
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'dart:convert';

EmployeeDto employeeDtoFromJson(String str) =>
    EmployeeDto.fromJson(json.decode(str));

String employeeDtoToJson(EmployeeDto data) => json.encode(data.toJson());

class EmployeeDto {
  int? id;
  String? idNumber;
  String? name;
  String? phone;
  String? sex;
  String? username;
  int? role;

  EmployeeDto({
    this.id,
    this.idNumber,
    this.name,
    this.phone,
    this.sex,
    this.username,
    this.role,
  });

  factory EmployeeDto.fromJson(Map<String, dynamic> json) => EmployeeDto(
        id: json["id"],
        idNumber: json["idNumber"],
        name: json["name"],
        phone: json["phone"],
        sex: json["sex"],
        username: json["username"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idNumber": idNumber,
        "name": name,
        "phone": phone,
        "sex": sex,
        "username": username,
        "role": role,
      };
}
