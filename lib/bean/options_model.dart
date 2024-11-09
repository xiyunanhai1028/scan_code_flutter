/*
 * @Author: dfh
 * @Date: 2024-10-21 08:24:22
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'dart:convert';

OptionsBean optionsBeanFromJson(String str) =>
    OptionsBean.fromJson(json.decode(str));

String optionsBeanToJson(OptionsBean data) => json.encode(data.toJson());

class OptionsBean {
  String value;
  String label;

  OptionsBean({
    required this.value,
    required this.label,
  });

  factory OptionsBean.fromJson(Map<String, dynamic> json) => OptionsBean(
        value: json["value"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "label": label,
      };
}
