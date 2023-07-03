import 'dart:convert';

ListVideo listVideoFromJson(String str) => ListVideo.fromJson(json.decode(str));

String listVideoToJson(ListVideo data) => json.encode(data.toJson());

class ListVideo {
  int code;
  String message;
  int founded;
  List<Datum> data;

  ListVideo({
    required this.code,
    required this.message,
    required this.founded,
    required this.data,
  });

  factory ListVideo.fromJson(Map<String, dynamic> json) => ListVideo(
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
  Category category;
  String title;
  String video;
  String description;
  DateTime publishedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    required this.id,
    required this.adminId,
    required this.category,
    required this.title,
    required this.video,
    required this.description,
    required this.publishedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        adminId: json["adminId"],
        category: categoryValues.map[json["category"]]!,
        title: json["title"],
        video: json["video"],
        description: json["description"],
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
        "category": categoryValues.reverse[category],
        "title": title,
        "video": video,
        "description": description,
        "published_at": publishedAt.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

enum Category {
  INVESTASI_SYARIAH,
  KEUANGAN_SYARIAH,
  ASURANSI_SYARIAH,
  PERENCANAAN_KEUANGAN,
  PENGELOLAAN_KEUANGAN,
  EKONOMI_SYARIAH
}

final categoryValues = EnumValues({
  "Asuransi Syariah": Category.ASURANSI_SYARIAH,
  "Ekonomi Syariah": Category.EKONOMI_SYARIAH,
  "Investasi Syariah": Category.INVESTASI_SYARIAH,
  "Keuangan Syariah": Category.KEUANGAN_SYARIAH,
  "Pengelolaan Keuangan": Category.PENGELOLAAN_KEUANGAN,
  "Perencanaan Keuangan": Category.PERENCANAAN_KEUANGAN
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
