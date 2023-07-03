import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart' as s;

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  //Google Sign In
  final GoogleSignIn googleSignIn = GoogleSignIn();

  var startDate = DateTime(
          DateTime.now().year, DateTime.now().month - 1, DateTime.now().day)
      .obs;
  var endDate = DateTime.now().obs;
  var totalNominal = 0;
  var rekomendasiZakat = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getDataPemasukan();
  }

  Future<void> logoutGoogle() async {
    try {
      await googleSignIn.signOut();
      await auth.signOut();
      Get.offAllNamed(Routes.LANDING);
    } catch (e) {
      print(e);
    }
  }

  void logout() async {
    try {
      await auth.signOut();
      Get.offAllNamed(Routes.LANDING);
    } catch (e) {
      print('Gagal Logout. $e');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamNotes() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore
        .collection("users")
        .doc(uid)
        .collection("notes")
        .orderBy(
          "created_at",
          descending: true,
        )
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamProfile() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection("users").doc(uid).snapshots();
  }

  void deleteNote(String docID) async {
    try {
      String uid = auth.currentUser!.uid;
      await firestore
          .collection("users")
          .doc(uid)
          .collection("notes")
          .doc(docID)
          .delete();
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan", "Gagal Hapus note");
    }
  }

  Future<void> getDataPemasukan() async {
    String uid = auth.currentUser!.uid;
    var snapshotsPendapatan = await firestore
        .collection("users")
        .doc(uid)
        .collection("transaksi")
        .where("jenisTransaksi", isEqualTo: "Pendapatan")
        .where("tanggalTransaksi",
            isGreaterThanOrEqualTo: startDate.value,
            isLessThanOrEqualTo: endDate.value)
        .get();

    snapshotsPendapatan.docs.forEach((doc) {
      // Dapatkan nilai nominal dari dokumen
      int nominal = doc.data()['nominal'];

      // Jumlahkan nilai nominal ke totalNominal
      totalNominal += nominal;
    });

    print(totalNominal);
    rekomendasiZakat.value = 0.25 * totalNominal.toDouble();
  }
}
