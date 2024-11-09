/*
 * @Author: dfh
 * @Date: 2024-10-09 16:49:47
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'dart:convert';

CategoryVo categoryVoFromJson(String str) => CategoryVo.fromJson(json.decode(str));

String categoryVoToJson(CategoryVo data) => json.encode(data.toJson());

class CategoryVo {
    int total;
    List<Category> records;

    CategoryVo({
        required this.total,
        required this.records,
    });

    factory CategoryVo.fromJson(Map<String, dynamic> json) => CategoryVo(
        total: json["total"],
        records: List<Category>.from(json["records"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
    };
}

class Category {
    int id;
    int type;
    String name;
    int sort;
    int status;
    String createTime;
    String updateTime;
    int createUser;
    int updateUser;

    Category({
        required this.id,
        required this.type,
        required this.name,
        required this.sort,
        required this.status,
        required this.createTime,
        required this.updateTime,
        required this.createUser,
        required this.updateUser,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        sort: json["sort"],
        status: json["status"],
        createTime: json["createTime"],
        updateTime: json["updateTime"],
        createUser: json["createUser"],
        updateUser: json["updateUser"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "sort": sort,
        "status": status,
        "createTime": createTime,
        "updateTime": updateTime,
        "createUser": createUser,
        "updateUser": updateUser,
    };
}
