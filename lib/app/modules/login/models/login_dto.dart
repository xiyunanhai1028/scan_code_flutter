import 'dart:convert';

class LoginDto {
    String username;
    String password;

    LoginDto({
        required this.username,
        required this.password,
    });

    factory LoginDto.fromJson(Map<String, dynamic> json) => LoginDto(
        username: json["username"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
    };
}
