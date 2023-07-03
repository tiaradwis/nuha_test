import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuha/app/modules/literasi/models/balasan_komentar_video_model.dart';
import 'package:nuha/app/modules/literasi/models/komentar_video_model.dart';
import 'package:nuha/app/modules/literasi/models/pengguna_model.dart';

class KomentarVideoController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final String idVideo;
  final comments = <KomentarVideo>[].obs;
  final pengguna = <Pengguna>[].obs;
  final replys = <ReplyVideo>[].obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController descC = TextEditingController();
  TextEditingController replyDescC = TextEditingController();

  //inisialisasi animmasi transisi
  late AnimationController animationController;
  late Animation<double> animation;

  KomentarVideoController({required this.idVideo});

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Stream<List<KomentarVideo>> loadComments() {
    final usersCollection = FirebaseFirestore.instance.collection('users');
    final commentsCollection =
        FirebaseFirestore.instance.collection('comments_video');

    return usersCollection.snapshots().asyncMap((usersSnapshot) {
      return commentsCollection
          .where('idVideo', isEqualTo: idVideo)
          .orderBy('createdAt', descending: true)
          .get()
          .then((commentQuerySnapshot) {
        // membersihkan data sebelum memuat perubahan data baru
        comments.clear();
        var usersDocs = usersSnapshot.docs;
        var commentsDocs = commentQuerySnapshot.docs;
        var uniqueComments = commentsDocs
            .map((commentDoc) {
              var commentData = commentDoc.data();

              for (var userDoc in usersDocs) {
                var uid = userDoc.data()['uid'];
                var userData = userDoc.data();
                if (uid == commentData['idUser']) {
                  if (userData['profile'] != null) {
                    var profile = userData['profile'];
                    return KomentarVideo(
                      idKomentar: commentDoc.id,
                      idVideo: commentData['idVideo'],
                      idUser: commentData['idUser'],
                      name: userData['name'],
                      imageURL: profile,
                      descKomentar: commentData['descKomentar'],
                      createdAt: commentData['createdAt'].toDate(),
                    );
                  } else {
                    var linkProfile = userData['name'];
                    var profile =
                        "https://ui-avatars.com/api/?name=$linkProfile]";
                    return KomentarVideo(
                      idKomentar: commentDoc.id,
                      idVideo: commentData['idVideo'],
                      idUser: commentData['idUser'],
                      name: userData['name'],
                      imageURL: profile,
                      descKomentar: commentData['descKomentar'],
                      createdAt: commentData['createdAt'].toDate(),
                    );
                  }
                }
              }

              return null;
            })
            .whereType<KomentarVideo>()
            .toList();

        comments.addAll(uniqueComments);
        return comments.toList();
      });
    });
  }

  Stream<List<ReplyVideo>> loadReplyComments(String idKomentar) {
    final usersCollection = FirebaseFirestore.instance.collection('users');
    final commentsCollection =
        FirebaseFirestore.instance.collection('comments_video');

    return usersCollection.snapshots().asyncMap((usersSnapshot) {
      return commentsCollection
          .doc(idKomentar)
          .collection('reply_comment_video')
          .orderBy('createdAt', descending: true)
          .get()
          .then((commentQuerySnapshot) {
        // membersihkan data sebelum memuat perubahan data baru
        replys.clear();
        var usersDocs = usersSnapshot.docs;
        var commentsDocs = commentQuerySnapshot.docs;
        var uniqueComments = commentsDocs
            .map((commentDoc) {
              var commentData = commentDoc.data();

              for (var userDoc in usersDocs) {
                var uid = userDoc.data()['uid'];
                var userData = userDoc.data();
                if (uid == commentData['idUser']) {
                  if (userData['profile'] != null) {
                    var profile = userData['profile'];
                    return ReplyVideo(
                      idReply: commentDoc.id,
                      idKomentar: commentDoc.id,
                      idVideo: commentData['idVideo'],
                      idUser: commentData['idUser'],
                      name: userData['name'],
                      imageURL: profile,
                      descBalasan: commentData['descBalasan'],
                      createdAt: commentData['createdAt'].toDate(),
                    );
                  } else {
                    var linkProfile = userData['name'];
                    var profile =
                        "https://ui-avatars.com/api/?name=$linkProfile]";
                    return ReplyVideo(
                      idReply: commentDoc.id,
                      idKomentar: commentDoc.id,
                      idVideo: commentData['idVideo'],
                      idUser: commentData['idUser'],
                      name: userData['name'],
                      imageURL: profile,
                      descBalasan: commentData['descBalasan'],
                      createdAt: commentData['createdAt'].toDate(),
                    );
                  }
                }
              }

              return null;
            })
            .whereType<ReplyVideo>()
            .toList();

        replys.addAll(uniqueComments);
        return replys.toList();
      });
    });
  }

  Future<Map<String, dynamic>?> getProfile() async {
    try {
      String uid = auth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> docUser =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      return docUser.data();
    } catch (e) {
      print('Tidak dapat get data user');
      return null;
    }
  }

  Future<void> addComment(String descKomentar) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance.collection('comments_video').add({
      'idVideo': idVideo,
      'idUser': currentUser!.uid,
      'descKomentar': descKomentar,
      'createdAt': DateTime.now(),
    });
  }

  Future<void> addReplyComment(String idKomentar, String descBalasan) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('comments_video')
        .doc(idKomentar)
        .collection('reply_comment_video')
        .add({
      'idVideo': idVideo,
      'idUser': currentUser!.uid,
      'descBalasan': descBalasan,
      'createdAt': DateTime.now(),
    });
  }
}
