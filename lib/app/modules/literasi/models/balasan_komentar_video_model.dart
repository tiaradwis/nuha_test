class ReplyVideo {
  final String idReply;
  final String idKomentar;
  final String idVideo;
  final String idUser;
  final String name;
  final String imageURL;
  final String descBalasan;
  final DateTime createdAt;

  ReplyVideo({
    required this.idReply,
    required this.idKomentar,
    required this.idVideo,
    required this.idUser,
    required this.name,
    required this.imageURL,
    required this.descBalasan,
    required this.createdAt,
  });
}
