

import 'dart:convert';

ModelProvice modelProviceFromJson(String str) => ModelProvice.fromJson(json.decode(str));

String modelProviceToJson(ModelProvice data) => json.encode(data.toJson());

class ModelProvice {
  ModelProvice({
    required this.code,
    required this.msg,
    required this.error,
    required this.res,
  });

  int code;
  String msg;
  bool error;
  List<Re_Provice> res;

  factory ModelProvice.fromJson(Map<String, dynamic> json) => ModelProvice(
    code: json["code"],
    msg: json["msg"],
    error: json["error"],
    res: List<Re_Provice>.from(json["res"].map((x) => Re_Provice.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "error": error,
    "res": List<dynamic>.from(res.map((x) => x.toJson())),
  };
}

class Re_Provice {
  Re_Provice({
    required  this.id,
    required  this.name,
  });

  String id;
  String name;

  factory Re_Provice.fromJson(Map<String, dynamic> json) => Re_Provice(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
