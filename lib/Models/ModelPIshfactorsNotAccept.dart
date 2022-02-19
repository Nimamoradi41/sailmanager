// To parse this JSON data, do
//
//     final modelPIshfactorsNotAccept = modelPIshfactorsNotAcceptFromJson(jsonString);

import 'dart:convert';

ModelPIshfactorsNotAccept modelPIshfactorsNotAcceptFromJson(String str) => ModelPIshfactorsNotAccept.fromJson(json.decode(str));

String modelPIshfactorsNotAcceptToJson(ModelPIshfactorsNotAccept data) => json.encode(data.toJson());

class ModelPIshfactorsNotAccept {
  ModelPIshfactorsNotAccept({
    required this.code,
    required this.msg,
    required   this.error,
    required this.res,
  });

  int code;
  String msg;
  bool error;
  List<Re_NotAccept> res;

  factory ModelPIshfactorsNotAccept.fromJson(Map<String, dynamic> json) => ModelPIshfactorsNotAccept(
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

class Re_NotAccept {
  Re_NotAccept({
    required   this.tedJoz,
    required  this.tedVah,
    required  this.tedKol,
    required  this.payment,
    required  this.date,
    required  this.flag,
    required   this.customerName,
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

  factory Re_NotAccept.fromJson(Map<String, dynamic> json) => Re_NotAccept(
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
