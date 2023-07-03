import 'dart:convert';

ListArtikel listArtikelFromJson(String str) =>
    ListArtikel.fromJson(json.decode(str));

String listArtikelToJson(ListArtikel data) => json.encode(data.toJson());

class ListArtikel {
  int code;
  String message;
  int founded;
  List<Datum> data;

  ListArtikel({
    required this.code,
    required this.message,
    required this.founded,
    required this.data,
  });

  factory ListArtikel.fromJson(Map<String, dynamic> json) => ListArtikel(
        code: json["code"],
        message: json["message"],
        founded: json["founded"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "founded": founded,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String adminId;
  String title;
  Category category;
  String content;
  String imageUrl;
  Writer writer;
  String readTime;
  DateTime publishedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    required this.id,
    required this.adminId,
    required this.title,
    required this.category,
    required this.content,
    required this.imageUrl,
    required this.writer,
    required this.readTime,
    required this.publishedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        adminId: json["adminId"],
        title: json["title"],
        category: categoryValues.map[json["category"]]!,
        content: json["content"],
        imageUrl: json["image_url"],
        writer: writerValues.map[json["writer"]]!,
        readTime: json["read_time"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "adminId": adminId,
        "title": title,
        "category": categoryValues.reverse[category],
        "content": content,
        "image_url": imageUrl,
        "writer": writerValues.reverse[writer],
        "read_time": readTime,
        "published_at": publishedAt.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

enum Category { TABUNGAN_SYARIAH, KEUANGAN_SYARIAH }

final categoryValues = EnumValues({
  "Keuangan Syariah": Category.KEUANGAN_SYARIAH,
  "Tabungan Syariah": Category.TABUNGAN_SYARIAH
});

enum Writer {
  FITRIA,
  FUJI_PRATIWI,
  LIDA_PUSPANINGTYAS,
  FRISKA_YOLANDHA,
  AHMAD_FIKRI_NOOR,
  ICHSAN_EMRALD_ALAMSYAH,
  GITA_AMANDA
}

final writerValues = EnumValues({
  "Ahmad Fikri Noor": Writer.AHMAD_FIKRI_NOOR,
  "Fitria": Writer.FITRIA,
  "Friska Yolandha": Writer.FRISKA_YOLANDHA,
  "Fuji Pratiwi": Writer.FUJI_PRATIWI,
  "Gita Amanda": Writer.GITA_AMANDA,
  "Ichsan Emrald Alamsyah": Writer.ICHSAN_EMRALD_ALAMSYAH,
  "Lida Puspaningtyas": Writer.LIDA_PUSPANINGTYAS
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
