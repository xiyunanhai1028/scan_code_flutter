import 'dart:convert';

EmployeeModel employeeModelFromJson(String str) => EmployeeModel.fromJson(json.decode(str));

String employeeModelToJson(EmployeeModel data) => json.encode(data.toJson());

class EmployeeModel {
    int total;
    List<Record> records;

    EmployeeModel({
        required this.total,
        required this.records,
    });

    factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        total: json["total"],
        records: List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
    };
}

class Record {
    int id;
    String username;
    String name;
    String password;
    String phone;
    String sex;
    String idNumber;
    int status;
    String createTime;
    String updateTime;
    int createUser;
    int updateUser;
    int role;

    Record({
        required this.id,
        required this.username,
        required this.name,
        required this.password,
        required this.phone,
        required this.sex,
        required this.idNumber,
        required this.status,
        required this.createTime,
        required this.updateTime,
        required this.createUser,
        required this.updateUser,
        required this.role,
    });

    factory Record.fromJson(Map<String, dynamic> json) => Record(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        password: json["password"],
        phone: json["phone"],
        sex: json["sex"],
        idNumber: json["idNumber"],
        status: json["status"],
        createTime: json["createTime"],
        updateTime: json["updateTime"],
        createUser: json["createUser"],
        updateUser: json["updateUser"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "password": password,
        "phone": phone,
        "sex": sex,
        "idNumber": idNumber,
        "status": status,
        "createTime": createTime,
        "updateTime": updateTime,
        "createUser": createUser,
        "updateUser": updateUser,
        "role": role,
    };
}
