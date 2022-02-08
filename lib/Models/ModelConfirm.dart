// To parse this JSON data, do
//
//     final modelConfirm = modelConfirmFromJson(jsonString);

import 'dart:convert';

ModelConfirm modelConfirmFromJson(String str) => ModelConfirm.fromJson(json.decode(str));

String modelConfirmToJson(ModelConfirm data) => json.encode(data.toJson());

class ModelConfirm {
  ModelConfirm({
    required  this.code,
    required  this.msg,
    required  this.error,
    required  this.res,
  });

  int code;
  String msg;
  bool error;
  bool res;

  factory ModelConfirm.fromJson(Map<String, dynamic> json) => ModelConfirm(
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
