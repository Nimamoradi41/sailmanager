// To parse this JSON data, do
//
//     final modelFactorsAll = modelFactorsAllFromJson(jsonString);

import 'dart:convert';

ModelFactorsAll modelFactorsAllFromJson(String str) => ModelFactorsAll.fromJson(json.decode(str));

String modelFactorsAllToJson(ModelFactorsAll data) => json.encode(data.toJson());

class ModelFactorsAll {
  ModelFactorsAll({
    required this.code,
    required  this.msg,
    required  this.error,
    required  this.res,
  });

  int code;
  String msg;
  bool error;
  List<Re_FactorsAlls> res;

  factory ModelFactorsAll.fromJson(Map<String, dynamic> json) => ModelFactorsAll(
    code: json["code"],
    msg: json["msg"],
    error: json["error"],
    res: List<Re_FactorsAlls>.from(json["res"].map((x) => Re_FactorsAlls.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "error": error,
    "res": List<dynamic>.from(res.map((x) => x.toJson())),
  };
}

class Re_FactorsAlls {
  Re_FactorsAlls({
    required  this.tedJoz,
    required  this.tedVah,
    required  this.tedKol,
    required  this.payment,
    required   this.date,
    required  this.flag,
    required  this.customerName,
    required  this.id,
  });

  String tedJoz;
  String tedVah;
  String tedKol;
  String payment;
  String date;
  int flag;
  String customerName;
  int id;

  factory Re_FactorsAlls.fromJson(Map<String, dynamic> json) => Re_FactorsAlls(
    tedJoz: json["tedJoz"],
    tedVah: json["tedVah"],
    tedKol: json["tedKol"],
    payment: json["payment"],
    date: json["date"],
    flag: json["flag"],
    customerName: json["customerName"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "tedJoz": tedJoz,
    "tedVah": tedVah,
    "tedKol": tedKol,
    "payment": payment,
    "date": date,
    "flag": flag,
    "customerName": customerName,
    "id": id,
  };
}
