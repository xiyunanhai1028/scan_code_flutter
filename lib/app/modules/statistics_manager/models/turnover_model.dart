import 'dart:convert';

TurnoverVo turnoverVoFromJson(String str) =>
    TurnoverVo.fromJson(json.decode(str));

String turnoverVoToJson(TurnoverVo data) => json.encode(data.toJson());

//营业额
class TurnoverVo {
  String dateList;
  String turnoverList;

  TurnoverVo({
    required this.dateList,
    required this.turnoverList,
  });

  factory TurnoverVo.fromJson(Map<String, dynamic> json) => TurnoverVo(
        dateList: json["dateList"],
        turnoverList: json["turnoverList"],
      );

  Map<String, dynamic> toJson() => {
        "dateList": dateList,
        "turnoverList": turnoverList,
      };
}
