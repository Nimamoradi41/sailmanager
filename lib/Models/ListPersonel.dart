// To parse this JSON data, do
//
//     final listPersonel = listPersonelFromJson(jsonString);

import 'dart:convert';

ListPersonel listPersonelFromJson(String str) => ListPersonel.fromJson(json.decode(str));

String listPersonelToJson(ListPersonel data) => json.encode(data.toJson());

class ListPersonel {
  ListPersonel({
    required this.code,
    required this.msg,
    required this.error,
    required this.res,
  });

  int code;
  String msg;
  bool error;
  List<RePerson> res;

  factory ListPersonel.fromJson(Map<String, dynamic> json) => ListPersonel(
    code: json["code"],
    msg: json["msg"],
    error: json["error"],
    res: List<RePerson>.from(json["res"].map((x) => RePerson.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "error": error,
    "res": List<dynamic>.from(res.map((x) => x.toJson())),
  };
}

class RePerson {
  RePerson({
    required this.visRdf,
    required  this.name,
    required this.tell1,
    required this.tell2,
    required this.cell,
  });

  int visRdf;
  String name;
  String tell1;
  String tell2;
  String cell;

  factory RePerson.fromJson(Map<String, dynamic> json) => RePerson(
    visRdf: json["visRdf"],
    name: json["name"],
    tell1: json["tell1"],
    tell2: json["tell2"],
    cell: json["cell"],
  );

  Map<String, dynamic> toJson() => {
    "visRdf": visRdf.toString(),
    "name": name,
    "tell1": tell1,
    "tell2": tell2,
    "cell": cell,
  };
}
