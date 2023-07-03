class Reply {
  final String idReply;
  final String idKomentar;
  final String idArtikel;
  final String idUser;
  final String name;
  final String imageURL;
  final String descBalasan;
  final DateTime createdAt;

  Reply({
    required this.idReply,
    required this.idKomentar,
    required this.idArtikel,
    required this.idUser,
    required this.name,
    required this.imageURL,
    required this.descBalasan,
    required this.createdAt,
  });
}
