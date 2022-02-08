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
    required this.res,
  });

  int code;
  String msg;
  bool error;
  Res res;

  factory ListCustomer.fromJson(Map<String, dynamic> json) => ListCustomer(
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
    required  this.list,
    required this.count,
    required this.page,
  });

  List<Customer_Db> list;
  int count;
  int page;

  factory Res.fromJson(Map<String, dynamic> json) => Res(
    list: List<Customer_Db>.from(json["list"].map((x) => Customer_Db.fromJson(x))),
    count: json["count"],
    page: json["page"],
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
    "count": count,
    "page": page,
  };
}

class Customer_Db {
  Customer_Db({
    required   this.id,
    required  this.name,
    required this.tell1,
    required this.tell2,
    required this.groupId,
    required this.address,
    required this.provinceId,
    required this.cityId,
    required this.masirId,
    required this.reginId,
  });

  int id;
  String name;
  String tell1;
  String tell2;
  int groupId;
  String address;
  int provinceId;
  int cityId;
  int masirId;
  int reginId;

  factory Customer_Db.fromJson(Map<String, dynamic> json) => Customer_Db(
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
  );

  Map<String, dynamic> toJson() => {
    "id": id.toString(),
    "name": name,
    "tell1": tell1,
    "tell2": tell2,
    "groupId": groupId.toString(),
    "address": address,
    "provinceId": provinceId.toString(),
    "cityId": cityId.toString(),
    "masirId": masirId.toString(),
    "reginId": reginId.toString(),
  };
}
