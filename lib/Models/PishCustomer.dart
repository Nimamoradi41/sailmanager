// To parse this JSON data, do
//
//     final pishCustomer = pishCustomerFromJson(jsonString);

import 'dart:convert';

import 'ModelPIshfactorsNotAccept.dart';

PishCustomer pishCustomerFromJson(String str) => PishCustomer.fromJson(json.decode(str));

String pishCustomerToJson(PishCustomer data) => json.encode(data.toJson());

class PishCustomer {
  PishCustomer({
    required   this.code,
    required  this.msg,
    required   this.error,
    required   this.res,
  });

  int code;
  String msg;
  bool error;
  List<Re_NotAccept> res;

  factory PishCustomer.fromJson(Map<String, dynamic> json) => PishCustomer(
    code: json["code"],
    msg: json["msg"],
    error: json["error"],
    res: List<Re_NotAccept>.from(json["res"].map((x) => Re_NotAccept.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "error": error,
    "res": List<dynamic>.from(res.map((x) => x.toJson())),
  };
}


