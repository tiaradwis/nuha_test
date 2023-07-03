class Komentar {
  final String idKomentar;
  final String idArtikel;
  final String idUser;
  final String name;
  final String imageURL;
  final String descKomentar;
  final DateTime createdAt;

  Komentar({
    required this.idKomentar,
    required this.idArtikel,
    required this.idUser,
    required this.name,
    required this.imageURL,
    required this.descKomentar,
    required this.createdAt,
  });
}
