import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuha/app/modules/literasi/models/balasan_komentar_artikel_model.dart';
import 'package:nuha/app/modules/literasi/models/komentar_artikel_model.dart';
import 'package:nuha/app/modules/literasi/models/pengguna_model.dart';

class KomentarArtikelController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final String idArtikel;
  final comments = <Komentar>[].obs;
  final pengguna = <Pengguna>[].obs;
  final replys = <Reply>[].obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController descC = TextEditingController();
  TextEditingController replyDescC = TextEditingController();

  //inisialisasi animasi transisi
  late AnimationController animationController;
  late Animation<double> animation;

  KomentarArtikelController({required this.idArtikel});

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

  Stream<List<Komentar>> loadComments() {
    final usersCollection = FirebaseFirestore.instance.collection('users');
    final commentsCollection =
        FirebaseFirestore.instance.collection('comments');

    return usersCollection.snapshots().asyncMap((usersSnapshot) {
      return commentsCollection
          .where('idArtikel', isEqualTo: idArtikel)
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
                    return Komentar(
                      idKomentar: commentDoc.id,
                      idArtikel: commentData['idArtikel'],
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
                    return Komentar(
                      idKomentar: commentDoc.id,
                      idArtikel: commentData['idArtikel'],
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
            .whereType<Komentar>()
            .toList();

        comments.addAll(uniqueComments);
        return comments.toList();
      });
    });

    // // Looping melalui pengguna
    // for (var userDoc in usersQuerySnapshot.datadocs) {
    //   var uid = userDoc.data()['uid'];
    //   // Query untuk mendapatkan data komentar berdasarkan userId dengan proyeksi
    //   var commentsQuerySnapshot = commentsCollection
    //       .where('idArtikel', isEqualTo: idArtikel)
    //       .where('idUser', isEqualTo: uid)
    //       .orderBy('createdAt', descending: true)
    //       .snapshots();

    //   // Loop melalui komentar pengguna
    //   for (var commentDoc in commentsQuerySnapshot.docs) {
    //     var commentData = commentDoc.data();

    //     final myModel = Komentar(
    //       idKomentar: commentDoc.id,
    //       idArtikel: commentData['idArtikel'],
    //       idUser: commentData['idUser'],
    //       descKomentar: commentData['descKomentar'],
    //       createdAt: commentData['createdAt'].toDate(),
    //     );

    //     comments.add(myModel);
    //   }
    // }
  }

  Stream<List<Reply>> loadReplyComments(String idKomentar) {
    final usersCollection = FirebaseFirestore.instance.collection('users');
    final commentsCollection =
        FirebaseFirestore.instance.collection('comments');

    return usersCollection.snapshots().asyncMap((usersSnapshot) {
      return commentsCollection
          .doc(idKomentar)
          .collection('reply_comment_article')
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
                    return Reply(
                      idReply: commentDoc.id,
                      idKomentar: commentDoc.id,
                      idArtikel: commentData['idArtikel'],
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
                    return Reply(
                      idReply: commentDoc.id,
                      idKomentar: commentDoc.id,
                      idArtikel: commentData['idArtikel'],
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
            .whereType<Reply>()
            .toList();

        replys.addAll(uniqueComments);
        return replys.toList();
      });
    });

    // final querySnapshot = FirebaseFirestore.instance
    //     .collection('comments')
    //     .doc(idKomentar)
    //     .collection('reply_comment_article')
    //     .orderBy('createdAt', descending: true)
    //     .snapshots();

    // querySnapshot.listen((snapshot) {
    //   _replys.value = snapshot.docs.map((doc) {
    //     return Reply(
    //         idReply: doc.id,
    //         idKomentar: idKomentar,
    //         idArtikel: doc.data()['idArtikel'],
    //         idUser: doc.data()['idUser'],
    //         descBalasan: doc.data()['descBalasan'],
    //         createdAt: doc.data()['createdAt'].toDate());
    //   }).toList();
    // });

    // return querySnapshot;
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

    await FirebaseFirestore.instance.collection('comments').add({
      'idArtikel': idArtikel,
      'idUser': currentUser!.uid,
      'descKomentar': descKomentar,
      'createdAt': DateTime.now(),
    });
  }

  Future<void> addReplyComment(String idKomentar, String descBalasan) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('comments')
        .doc(idKomentar)
        .collection('reply_comment_article')
        .add({
      'idArtikel': idArtikel,
      'idUser': currentUser!.uid,
      'descBalasan': descBalasan,
      'createdAt': DateTime.now(),
    });
  }

  Future<void> deleteComment(String id) async {
    await FirebaseFirestore.instance.collection('comments').doc(id).delete();
    comments.removeWhere((comment) => comment.idKomentar == id);
  }
}
