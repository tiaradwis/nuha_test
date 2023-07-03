import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/cashflow/controllers/cashflow_controller.dart';
import 'package:nuha/app/modules/cashflow/views/anggaran_view.dart';

class AnggaranEditController extends GetxController {
  final con = Get.find<CashflowController>();
  RxBool isLoading = false.obs;
  TextEditingController nomAnggaranC = TextEditingController();
  var kategoriC = "Pilih Kategori".obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  void successMsg(String msg) {
    Get.snackbar(
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInOutBack,
      backgroundColor: buttonColor1,
      colorText: backgroundColor1,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
      "Berhasil",
      msg,
    );
  }

  void errMsg(String msg) {
    Get.snackbar(
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInOutBack,
      backgroundColor: errColor,
      colorText: backgroundColor1,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
      "Terjadi Kesalahan",
      msg,
    );
  }

  Future<Map<String, dynamic>?> getAnggaranById(String docId) async {
    try {
      String uid = auth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> doc = await firestore
          .collection("users")
          .doc(uid)
          .collection("anggaran")
          .doc(docId)
          .get();
      // sisaTransAnggaran(doc.data()?["kategori"], doc.data()?["nominal"], docId);
      con.countAnggaranDetail(doc.data()?["kategori"]);

      return doc.data();
    } catch (e) {
      errMsg("Coba lagi nanti!");
    }
    return null;
  }

  void updateAnggaranById(context, String docId) async {
    isLoading.value = true;
    try {
      String uid = auth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> doc = await firestore
          .collection("users")
          .doc(uid)
          .collection("anggaran")
          .doc(docId)
          .get();

      con.countAnggaranDetail(doc.data()?["kategori"]);

      await firestore
          .collection("users")
          .doc(uid)
          .collection("anggaran")
          .doc(docId)
          .update({
        "nominal": int.parse(nomAnggaranC.text.replaceAll('.', '')),
        "updatedAt": DateTime.now().toIso8601String(),
      });

      isLoading.value = false;
      con.totalNominalKategori();
      successMsg("Date berhasil diubah!");

      Navigator.pop(context);
    } catch (e) {
      // print(e);
      isLoading.value = false;
      errMsg("Data gagal diubah, coba lagi nanti!");
    }
  }

  void deleteAnggaranById(context, String docId) async {
    isLoading.value = true;
    try {
      String uid = auth.currentUser!.uid;
      await firestore
          .collection("users")
          .doc(uid)
          .collection("anggaran")
          .doc(docId)
          .delete();
      isLoading.value = false;
      con.totalNominalKategori();
      con.countAnggaranTerpakai();

      Get.to(() => AnggaranView());

      successMsg("Data berhasil kami hapus dari database.");
    } catch (e) {
      isLoading.value = false;
      errMsg("Tidak dapat menghapus data, coba lagi nanti!");
    }
  }
}
