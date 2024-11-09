import 'dart:convert';

ShopInfoVo shopInfoVoFromJson(String str) => ShopInfoVo.fromJson(json.decode(str));

String shopInfoVoToJson(ShopInfoVo data) => json.encode(data.toJson());

class ShopInfoVo {
    String title;
    String address;
    String startTitle;
    String endTime;
    int isStart;
    String description;
    String image;

    ShopInfoVo({
        required this.title,
        required this.address,
        required this.startTitle,
        required this.endTime,
        required this.isStart,
        required this.description,
        required this.image,
    });

    factory ShopInfoVo.fromJson(Map<String, dynamic> json) => ShopInfoVo(
        title: json["title"],
        address: json["address"],
        startTitle: json["start_title"],
        endTime: json["end_time"],
        isStart: json["isStart"],
        description: json["description"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "address": address,
        "start_title": startTitle,
        "end_time": endTime,
        "isStart": isStart,
        "description": description,
        "image": image,
    };
}
