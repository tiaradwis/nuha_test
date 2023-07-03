import 'dart:convert';

DaftarPinjol daftarPinjolFromJson(String str) =>
    DaftarPinjol.fromJson(json.decode(str));

String daftarPinjolToJson(DaftarPinjol data) => json.encode(data.toJson());

class DaftarPinjol {
  int code;
  String message;
  int founded;
  List<Data> data;

  DaftarPinjol({
    required this.code,
    required this.message,
    required this.founded,
    required this.data,
  });

  factory DaftarPinjol.fromJson(Map<String, dynamic> json) => DaftarPinjol(
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
  String situs;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.namaPlatform,
    required this.situs,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'],
        namaPlatform: json['namaPlatform'],
        situs: json['situs'],
        status: json['status'],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "namaPlatform": namaPlatform,
        "situs": situs,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
