import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nuha/app/modules/literasi/models/detail_artikel_model.dart';
import 'package:nuha/app/modules/literasi/providers/list_artikel_provider.dart';
import 'package:nuha/app/utility/result_state.dart';

class DetailArtikelController extends GetxController {
  ListArtikelProvider listArtikelProvider;
  DetailArtikelController(
      {required this.listArtikelProvider, required String idArtikel}) {
    fetchDetailArtikel(idArtikel);
  }

  var resultState = ResultState.loading().obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  RxBool isBookmarked = false.obs;

  String _message = '';
  late DetailArtikel _detailArtikel;

  DetailArtikel get resultDetailArtikel => _detailArtikel;
  String get message => _message;

  Future<dynamic> fetchDetailArtikel(idArtikel) async {
    try {
      final artikel = await listArtikelProvider.getDetailArtikel(idArtikel);
      if (artikel.data.toJson().isEmpty) {
        resultState.value = ResultState.noData();
        return _message = 'Data Kosong';
      } else {
        resultState.value = ResultState.hasData(artikel);
        return _detailArtikel = artikel;
      }
    } catch (e) {
      resultState.value = ResultState.error('An error occurred: $e');
      return _message = '$e';
    }
  }

  void toogleBookmark(String idArtikel) async {
    isLoading.value = true;
    String uid = auth.currentUser!.uid;
    String bookmarkId = "${auth.currentUser!.uid}_artikel_$idArtikel";

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection("bookmark_article")
        .doc(bookmarkId)
        .get();
    final bool doesDocExist = doc.exists;

    if (doesDocExist == true) {
      print('Hapus');
      isBookmarked.value = false;
      isLoading.value = false;
    } else {
      try {
        await firestore
            .collection("users")
            .doc(uid)
            .collection("bookmark_article")
            .doc(bookmarkId)
            .set({
          "uid": auth.currentUser!.uid,
          "idArtikel": idArtikel,
          "createdAt": DateTime.now()
        });
        isBookmarked.value = true;
        isLoading.value = false;
      } catch (e) {
        // ignore: avoid_print
        print(e);
        isLoading.value = false;
        Get.snackbar("Terjadi Kesalahan", "Gagal menambahkan note");
      }
    }
  }

  isBookmarkede(String idArtikel) async {
    String uid = auth.currentUser!.uid;
    String bookmarkId = "${auth.currentUser!.uid}_artikel_$idArtikel";

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection("bookmark_article")
        .doc(bookmarkId)
        .get();
    final bool doesDocExist = doc.exists;

    if (doesDocExist == true) {
      return true;
    } else {
      return false;
    }
  }
}
