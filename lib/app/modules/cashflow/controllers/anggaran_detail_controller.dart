import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:nuha/app/modules/cashflow/controllers/cashflow_controller.dart';

class AnggaranDetailController extends GetxController {
  final con = Get.find<CashflowController>();

  TextEditingController nomAnggaranC = TextEditingController();
  TextEditingController searchTransInAnggaranC = TextEditingController();
  var kategoriC = "Pilih Kategori".obs;
  var querySearch = [].obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  Color getProgressColor(double percent) {
    if (percent >= 0.95) {
      return Colors.red;
    } else if (percent >= 0.9) {
      return Colors.orange;
    } else if (percent >= 0.8) {
      return buttonColor2;
    } else {
      return buttonColor1;
    }
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
      // print(e);
      return null;
    }
  }

  void searchTransInAnggaran(String data, String katTransaksi) async {
    // print(data);
    String uid = auth.currentUser!.uid;

    if (data.isEmpty) {
      querySearch.value = [];
    } else {
      var capitalize = data.capitalizeFirst;
      // print(capitalize);
      if (querySearch.isEmpty && data.isNotEmpty) {
        CollectionReference transInAnggaran =
            firestore.collection("users").doc(uid).collection("transaksi");
        final keyNameResult = await transInAnggaran
            .where("kategori", isEqualTo: katTransaksi)
            .where("namaTransaksi", isGreaterThanOrEqualTo: capitalize)
            .where("namaTransaksi", isLessThan: '${capitalize}z')
            .get();

        // print("Total data: ${keyNameResult.docs.length}");
        if (keyNameResult.docs.isNotEmpty) {
          querySearch.value = [];
          for (int i = 0; i < keyNameResult.docs.length; i++) {
            querySearch
                .add(keyNameResult.docs[i].data() as Map<String, dynamic>);
          }
          // print(querySearch);
        }
      }
    }

    querySearch.refresh();
    update();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamTransaksiKategori(
      String katTransaksi) async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection("users")
        .doc(uid)
        .collection("transaksi")
        .where("kategori", isEqualTo: katTransaksi)
        .snapshots();
  }
}
