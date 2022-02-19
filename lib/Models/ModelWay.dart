// To parse this JSON data, do
//
//     final modelWay = modelWayFromJson(jsonString);

import 'dart:convert';

ModelWay modelWayFromJson(String str) => ModelWay.fromJson(json.decode(str));

String modelWayToJson(ModelWay data) => json.encode(data.toJson());

class ModelWay {
  ModelWay({
    required this.code,
    required this.msg,
    required this.error,
    required this.res,
  });

  int code;
  String msg;
  bool error;
  List<ReWay> res;

  factory ModelWay.fromJson(Map<String, dynamic> json) => ModelWay(
    code: json["code"],
    msg: json["msg"],
    error: json["error"],
    res: List<ReWay>.from(json["res"].map((x) => ReWay.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "error": error,
    "res": List<dynamic>.from(res.map((x) => x.toJson())),
  };
}

class ReWay {
  ReWay({
    required this.id,
    required  this.name,
  });

  String id;
  String name;

  factory ReWay.fromJson(Map<String, dynamic> json) => ReWay(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
