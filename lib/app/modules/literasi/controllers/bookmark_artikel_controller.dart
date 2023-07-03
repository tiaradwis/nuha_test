import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class BookmarkArtikelController extends GetxController {
  final RxBool isBookmarked = false.obs;
  final RxInt bookmarkCount = 0.obs;
  late String bookmarkId;
  final String artikelId;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  BookmarkArtikelController({required this.artikelId});

  @override
  void onInit() {
    checkBookmarkStatus(artikelId);
    super.onInit();
  }

  void toggleBookmark(String artikelId, String title, String imageUrl) async {
    isBookmarked.value = !isBookmarked.value;
    String uid = auth.currentUser!.uid;
    String id = "${auth.currentUser!.uid}_artikel_$artikelId";
    bookmarkCount.value =
        isBookmarked.value ? bookmarkCount.value + 1 : bookmarkCount.value - 1;

    if (isBookmarked.value) {
      await firestore
          .collection("users")
          .doc(uid)
          .collection("bookmark_article")
          .doc(id)
          .set({
        'artikelId': artikelId,
        'userId': uid,
        'title': title,
        'imageUrl': imageUrl,
        'createdAt': DateTime.now().toIso8601String(),
      });
      bookmarkId = id;
    } else {
      await firestore
          .collection("users")
          .doc(uid)
          .collection("bookmark_article")
          .doc(id)
          .delete();
    }
  }

  void checkBookmarkStatus(String artikelId) async {
    String uid = auth.currentUser!.uid;
    String id = "${auth.currentUser!.uid}_artikel_$artikelId";
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection("bookmark_article")
          .doc(id)
          .get();
      final bool doesDocExist = doc.exists;
      if (doesDocExist == true) {
        isBookmarked.value = true;
      } else {
        isBookmarked.value = false;
      }
    } catch (error) {
      print(error.toString());
    }
  }
}
