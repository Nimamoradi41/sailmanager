// To parse this JSON data, do
//
//     final custGroup = custGroupFromJson(jsonString);

import 'dart:convert';

CustGroup2 custGroupFromJson(String str) => CustGroup2.fromJson(json.decode(str));

String custGroupToJson(CustGroup2 data) => json.encode(data.toJson());

class CustGroup2 {
  CustGroup2({
    required this.code,
    required this.msg,
    required this.error,
    required this.res,
  });

  int code;
  String msg;
  bool error;
  List<Re> res;

  factory CustGroup2.fromJson(Map<String, dynamic> json) => CustGroup2(
    code: json["code"],
    msg: json["msg"],
    error: json["error"],
    res: List<Re>.from(json["res"].map((x) => Re.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "error": error,
    "res": List<dynamic>.from(res.map((x) => x.toJson())),
  };
}

class Re {
  Re({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Re.fromJson(Map<String, dynamic> json) => Re(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
