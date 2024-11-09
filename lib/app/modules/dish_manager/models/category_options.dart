import 'dart:convert';

List<CategoryOptions> categoryOptionsFromJson(String str) => List<CategoryOptions>.from(json.decode(str).map((x) => CategoryOptions.fromJson(x)));

String categoryOptionsToJson(List<CategoryOptions> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryOptions {
    int id;
    int type;
    String name;
    int sort;
    int status;
    String createTime;
    String updateTime;
    int createUser;
    int updateUser;

    CategoryOptions({
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

    factory CategoryOptions.fromJson(Map<String, dynamic> json) => CategoryOptions(
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