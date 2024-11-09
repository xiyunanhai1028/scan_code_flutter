import 'dart:convert';

Top10Model top10ModelFromJson(String str) =>
    Top10Model.fromJson(json.decode(str));

String top10ModelToJson(Top10Model data) => json.encode(data.toJson());

class Top10Model {
  String nameList;
  String numberList;

  Top10Model({
    required this.nameList,
    required this.numberList,
  });

  factory Top10Model.fromJson(Map<String, dynamic> json) => Top10Model(
        nameList: json["nameList"],
        numberList: json["numberList"],
      );

  Map<String, dynamic> toJson() => {
        "nameList": nameList,
        "numberList": numberList,
      };
}
