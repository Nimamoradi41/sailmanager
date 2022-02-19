// To parse this JSON data, do
//
//     final modelCity = modelCityFromJson(jsonString);

import 'dart:convert';

ModelCity modelCityFromJson(String str) => ModelCity.fromJson(json.decode(str));

String modelCityToJson(ModelCity data) => json.encode(data.toJson());

class ModelCity {
  ModelCity({
    required   this.code,
    required  this.msg,
    required this.error,
    required  this.res,
    required this.count,
    required this.page,
  });

  int code;
  String msg;
  bool error;
  List<ReC_City> res;
  int count;
  int page;

  factory ModelCity.fromJson(Map<String, dynamic> json) => ModelCity(
    code: json["code"],
    msg: json["msg"],
    error: json["error"],
    res: List<ReC_City>.from(json["res"].map((x) => ReC_City.fromJson(x))),
    count: json["count"],
    page: json["page"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "error": error,
    "res": List<dynamic>.from(res.map((x) => x.toJson())),
    "count": count,
    "page": page,
  };
}

  class ReC_City {
    ReC_City({
      required this.id,
      required  this.provinceId,
      required this.name,
    });

    String id;
    String provinceId;
    String name;

    factory ReC_City.fromJson(Map<dynamic, dynamic> json) => ReC_City(
      id: json["id"],
      provinceId: json["provinceId"],
      name: json["name"]as String,
    );

    Map<String, dynamic> toJson() => {
      "id": id,
      "provinceId": provinceId,
      "name": name,
    };
}
