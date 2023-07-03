import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class BookmarkedArtikelController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  RxBool bookmarkedArtikel = false.obs;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamBookmarked() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore
        .collection("users")
        .doc(uid)
        .collection("bookmark_article")
        .orderBy(
          "createdAt",
          descending: true,
        )
        .snapshots();
  }
}
