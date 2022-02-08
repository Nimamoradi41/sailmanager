// To parse this JSON data, do
//
//     final onlineModel = onlineModelFromJson(jsonString);

import 'dart:convert';

OnlineModel onlineModelFromJson(String str) => OnlineModel.fromJson(json.decode(str));

String onlineModelToJson(OnlineModel data) => json.encode(data.toJson());

class OnlineModel {
  OnlineModel({
    required this.code,
    required this.msg,
    required  this.error,
    required  this.res,
  });

  int code;
  String msg;
  bool error;
  Res res;

  factory OnlineModel.fromJson(Map<String, dynamic> json) => OnlineModel(
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
    required this.lat,
    required this.lng,
    required this.datetime,
  });

  double lat;
  double lng;
  String datetime;

  factory Res.fromJson(Map<String, dynamic> json) => Res(
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
