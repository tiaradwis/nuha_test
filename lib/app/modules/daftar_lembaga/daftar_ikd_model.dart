import 'dart:convert';

DaftarIkd daftarIKDFromJson(String str) => DaftarIkd.fromJson(json.decode(str));

String daftarIKDToJson(DaftarIkd data) => json.encode(data.toJson());

class DaftarIkd {
  int code;
  String message;
  int founded;
  List<Data> data;

  DaftarIkd({
    required this.code,
    required this.message,
    required this.founded,
    required this.data,
  });

  factory DaftarIkd.fromJson(Map<String, dynamic> json) => DaftarIkd(
        code: json["code"],
        message: json["message"],
        founded: json["founded"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "founded": founded,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Data {
  int id;
  String namaPlatform;
  String namaPT;
  String suratTanda;
  String tglTercatat;
  DateTime createdAt;
  DateTime updatedAt;
  String klaster;

  Data(
      {required this.id,
      required this.namaPlatform,
      required this.namaPT,
      required this.suratTanda,
      required this.tglTercatat,
      required this.createdAt,
      required this.updatedAt,
      required this.klaster});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'],
        namaPlatform: json['namaPlatform'],
        namaPT: json['namaPT'],
        suratTanda: json['suratTanda'],
        tglTercatat: json['tglTercatat'],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        klaster: json['klaster'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "namaPlatform": namaPlatform,
        "namaPT": namaPT,
        "suratTanda": suratTanda,
        "tglTercatat": tglTercatat,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "klaster": klaster,
      };
}
