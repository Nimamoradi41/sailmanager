// To parse this JSON data, do
//
//     final modelDetailFactor = modelDetailFactorFromJson(jsonString);

import 'dart:convert';

ModelDetailFactor modelDetailFactorFromJson(String str) => ModelDetailFactor.fromJson(json.decode(str));

String modelDetailFactorToJson(ModelDetailFactor data) => json.encode(data.toJson());

class ModelDetailFactor {
  ModelDetailFactor({
    required  this.code,
    required   this.msg,
    required   this.error,
    required   this.res,
  });

  int code;
  String msg;
  bool error;
  Res_DetailFactor res;

  factory ModelDetailFactor.fromJson(Map<String, dynamic> json) => ModelDetailFactor(
    code: json["code"],
    msg: json["msg"],
    error: json["error"],
    res: Res_DetailFactor.fromJson(json["res"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "error": error,
    "res": res.toJson(),
  };
}

class Res_DetailFactor {
  Res_DetailFactor({
    required   this.listKala,
    required   this.countChkInWay,
    required      this.priceChkInWay,
    required   this.countChkReturn,
    required  this.priceChkReturn,
    required  this.etebar,
    required  this.Man,
    required  this.Takhfif,
  });


  List<ListKala> listKala;
  String countChkInWay;
  String priceChkInWay;
  String countChkReturn;
  String priceChkReturn;
  String etebar;
  String Takhfif;
  String Man;


  factory Res_DetailFactor.fromJson(Map<String, dynamic> json) => Res_DetailFactor(
    listKala: List<ListKala>.from(json["listKala"].map((x) => ListKala.fromJson(x))),
    countChkInWay: json["countChkInWay"],
    priceChkInWay: json["priceChkInWay"],
    countChkReturn: json["countChkReturn"],
    priceChkReturn: json["priceChkReturn"],
    etebar: json["Etebar"],
    Takhfif: json["Takhfif"],
    Man: json["Man"],
  );

  Map<String, dynamic> toJson() => {
    "listKala": List<dynamic>.from(listKala.map((x) => x.toJson())),
    "countChkInWay": countChkInWay,
    "priceChkInWay": priceChkInWay,
    "countChkReturn": countChkReturn,
    "priceChkReturn": priceChkReturn,
    "Etebar": etebar,
    "Man": Man,
    "Takhfif": Takhfif,
  };
}

class ListKala {
  ListKala({
    required this.naka,
    required  this.vah,
    required  this.joz,
    required  this.moh,
    required  this.kol,
  });

  String naka;
  String vah;
  String joz;
  String moh;
  String kol;

  factory ListKala.fromJson(Map<String, dynamic> json) => ListKala(
    naka: json["naka"],
    vah: json["vah"],
    joz: json["joz"],
    moh: json["moh"],
    kol: json["kol"],
  );

  Map<String, dynamic> toJson() => {
    "naka": naka,
    "vah": vah,
    "joz": joz,
    "moh": moh,
    "kol": kol,
  };
}
