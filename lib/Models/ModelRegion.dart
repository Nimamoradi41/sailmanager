// To parse this JSON data, do
//
//     final modelRegion = modelRegionFromJson(jsonString);

import 'dart:convert';

ModelRegion modelRegionFromJson(String str) => ModelRegion.fromJson(json.decode(str));

String modelRegionToJson(ModelRegion data) => json.encode(data.toJson());

class ModelRegion {
  ModelRegion({
    required this.code,
    required   this.msg,
    required this.error,
    required this.res,
  });

  int code;
  String msg;
  bool error;
  List<ReRegion> res;

  factory ModelRegion.fromJson(Map<String, dynamic> json) => ModelRegion(
    code: json["code"],
    msg: json["msg"],
    error: json["error"],
    res: List<ReRegion>.from(json["res"].map((x) => ReRegion.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "error": error,
    "res": List<dynamic>.from(res.map((x) => x.toJson())),
  };
}

class ReRegion {
  ReRegion({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory ReRegion.fromJson(Map<String, dynamic> json) => ReRegion(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
