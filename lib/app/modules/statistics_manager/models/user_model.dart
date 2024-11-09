/*
 * @Author: dfh
 * @Date: 2024-10-16 09:49:13
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'dart:convert';

UserVo userVoFromJson(String str) => UserVo.fromJson(json.decode(str));

String userVoToJson(UserVo data) => json.encode(data.toJson());

class UserVo {
    String dateList;
    String totalUserList;
    String newUserList;

    UserVo({
        required this.dateList,
        required this.totalUserList,
        required this.newUserList,
    });

    factory UserVo.fromJson(Map<String, dynamic> json) => UserVo(
        dateList: json["dateList"],
        totalUserList: json["totalUserList"],
        newUserList: json["newUserList"],
    );

    Map<String, dynamic> toJson() => {
        "dateList": dateList,
        "totalUserList": totalUserList,
        "newUserList": newUserList,
    };
}
