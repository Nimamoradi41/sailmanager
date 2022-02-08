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
  });

  int code;
  String msg;
  bool error;
  Res res;

  factory OfflineModel.fromJson(Map<String, dynamic> json) => OfflineModel(
    code: json["code"],
    msg: json["msg"],
    error: json["error"],
    res: Res.fromJson(json["res"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "error": error,
    "res": res.toJson(),
  };
}

class Res {
  Res({
    required this.latlng,
    required  this.count,
    required this.page,
  });

  List<Latlng> latlng;
  int count;
  int page;

  factory Res.fromJson(Map<String, dynamic> json) => Res(
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
  });

  double lat;
  double lng;
  String datetime;

  factory Latlng.fromJson(Map<String, dynamic> json) => Latlng(
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
    datetime: json["datetime"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
    "datetime": datetime,
  };
}
