// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.code,
    required this.msg,
    required this.error,
    required this.res,
  });

  int code;
  String msg;
  bool error;
  bool res;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    code: json["code"],
    msg: json["msg"],
    error: json["error"],
    res: json["res"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "error": error,
    "res": res,
  };
}
