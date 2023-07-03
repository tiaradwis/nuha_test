class LikeVideo {
  String id;
  String postId;
  String userId;

  LikeVideo({
    required this.id,
    required this.postId,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'post': postId,
      'userId': userId,
    };
  }

  factory LikeVideo.fromMap(Map<String, dynamic> map) {
    return LikeVideo(
      id: map['id'],
      postId: map['postId'],
      userId: map['userId'],
    );
  }
}
