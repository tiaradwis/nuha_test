class KomentarVideo {
  final String idKomentar;
  final String idVideo;
  final String idUser;
  final String name;
  final String imageURL;
  final String descKomentar;
  final DateTime createdAt;

  KomentarVideo({
    required this.idKomentar,
    required this.idVideo,
    required this.idUser,
    required this.name,
    required this.imageURL,
    required this.descKomentar,
    required this.createdAt,
  });
}
