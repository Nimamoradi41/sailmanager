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
  List<ReC> res;
  int count;
  int page;

  factory ModelCity.fromJson(Map<String, dynamic> json) => ModelCity(
    code: json["code"],
    msg: json["msg"],
    error: json["error"],
    res: List<ReC>.from(json["res"].map((x) => ReC.fromJson(x))),
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

class ReC {
  ReC({
    required this.id,
    required this.cityId,
    required this.name,
  });

  String id;
  String cityId;
  String name;

  factory ReC.fromJson(Map<String, dynamic> json) => ReC(
    id: json["id"],
    cityId: json["cityId"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cityId": cityId,
    "name": name,
  };
}
