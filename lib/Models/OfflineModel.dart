// To parse this JSON data, do
//
//     final offlineModel = offlineModelFromJson(jsonString);

import 'dart:convert';

OfflineModel offlineModelFromJson(String str) => OfflineModel.fromJson(json.decode(str));

String offlineModelToJson(OfflineModel data) => json.encode(data.toJson());

class OfflineModel {
  OfflineModel({
    required  this.code,
    required  this.msg,
    required  this.error,
    required  this.res,
    required  this.name,
  });

  int code;
  String msg;
  bool error;
  Res_Offline res;
  String name;

  factory OfflineModel.fromJson(Map<String, dynamic> json) => OfflineModel(
    code: json["code"],
    msg: json["msg"],
    error: json["error"],
    name: json["name"],
    res: Res_Offline.fromJson(json["res"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "error": error,
    "error": error,
    "name": name,
    "res": res.toJson(),
  };
}

class Res_Offline {
  Res_Offline({
    required this.latlng,
    required  this.count,
    required this.page,
  });

  List<Latlng> latlng;
  int count;
  int page;


  factory Res_Offline.fromJson(Map<String, dynamic> json) => Res_Offline(
    latlng: List<Latlng>.from(json["latlng"].map((x) => Latlng.fromJson(x))),
    count: json["count"],
    page: json["page"],
  );

  Map<String, dynamic> toJson() => {
    "latlng": List<dynamic>.from(latlng.map((x) => x.toJson())),
    "count": count,
    "page": page,
  };
}

class Latlng {
  Latlng({
    required this.lat,
    required  this.lng,
    required  this.datetime,
    required  this.name,
  });

  double lat;
  double lng;
  String datetime;
  String name;

  factory Latlng.fromJson(Map<String, dynamic> json) => Latlng(
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
    datetime: json["datetime"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
    "datetime": datetime,
    "name": name,
  };
}
