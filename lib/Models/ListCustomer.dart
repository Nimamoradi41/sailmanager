// To parse this JSON data, do
//
//     final listCustomer = listCustomerFromJson(jsonString);

import 'dart:convert';



ListCustomer listCustomerFromJson(String str) => ListCustomer.fromJson(json.decode(str));

String listCustomerToJson(ListCustomer data) => json.encode(data.toJson());

class ListCustomer {
  ListCustomer({
    required this.code,
    required  this.msg,
    required this.error,
    required  this.res,
  });

  int code;
  String msg;
  bool error;
  List<Re_Customer> res;

  factory ListCustomer.fromJson(Map<String, dynamic> json) => ListCustomer(
    code: json["code"],
    msg: json["msg"],
    error: json["error"],
    res: List<Re_Customer>.from(json["res"].map((x) => Re_Customer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "error": error,
    "res": List<dynamic>.from(res.map((x) => x.toJson())),
  };
}

class Re_Customer {
  Re_Customer({
    required this.id,
    required this.name,
    required  this.tell1,
    required this.tell2,
    required this.groupId,
    required this.address,
    required this.provinceId,
    required  this.cityId,
    required  this.masirId,
    required this.reginId,
    required this.man,
    required this.lat,
    required this.lng,
  });

  String id;
  String name;
  String tell1;
  String tell2;
  String groupId;
  String address;
  String provinceId;
  String cityId;
  String masirId;
  String reginId;
  String man;
  double lat;
  double lng;

  factory Re_Customer.fromJson(Map<String, dynamic> json) => Re_Customer(
    id: json["id"],
    name: json["name"],
    tell1: json["tell1"],
    tell2: json["tell2"],
    groupId: json["groupId"],
    address: json["address"],
    provinceId: json["provinceId"],
    cityId: json["cityId"],
    masirId: json["masirId"],
    reginId: json["reginId"],
    man: json["man"],
    lat: json["lat"],
    lng: json["lng"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "tell1": tell1,
    "tell2": tell2,
    "groupId": groupId,
    "address": address,
    "provinceId": provinceId,
    "cityId": cityId,
    "masirId": masirId,
    "reginId": reginId,
    "man": man,
    "lat": lat,
    "lng": lng,
  };
}
