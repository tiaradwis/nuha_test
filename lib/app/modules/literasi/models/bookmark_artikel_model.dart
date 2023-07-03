class Like {
  String id;
  String postId;
  String userId;

  Like({
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

  factory Like.fromMap(Map<String, dynamic> map) {
    return Like(
      id: map['id'],
      postId: map['postId'],
      userId: map['userId'],
    );
  }
}
