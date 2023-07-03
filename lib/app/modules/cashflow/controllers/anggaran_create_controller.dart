import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:nuha/app/modules/cashflow/controllers/cashflow_controller.dart';

class AnggaranCreateController extends GetxController {
  final con = Get.find<CashflowController>();
  TextEditingController nomAnggaranC = TextEditingController();
  TextEditingController searchAnggaranC = TextEditingController();
  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  var kategoriC = "Pilih Kategori".obs;
  var kategoriStat = "".obs;
  String jenisKategori = "";

  void updateKategori(text) {
    kategoriC.value = text;
    kategoriStat.value = "choosen";

    Get.back();
  }

  void kategoriCheck() {
    if (kategoriC.value == "Asuransi" ||
        kategoriC.value == "Pendidikan" ||
        kategoriC.value == "Transportasi" ||
        kategoriC.value == "Sosial") {
      jenisKategori = "Umum";
    } else if (kategoriC.value == "Makan" ||
        kategoriC.value == "Belanja" ||
        kategoriC.value == "Hiburan" ||
        kategoriC.value == "Tagihan" ||
        kategoriC.value == "Kesehatan") {
      jenisKategori = "Biaya Hidup";
    } else {
      jenisKategori = "Lainnya";
    }
  }

  void checkAnggaranKategori(String text) async {
    String uid = auth.currentUser!.uid;
    firestore
        .collection("users")
        .doc(uid)
        .collection("anggaran")
        .where("kategori", isEqualTo: text)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        // var anggaranActive = false;
        Get.back();
        Get.snackbar("Terjadi Kesalahan",
            "Anda sudah pernah membuat anggaran dengan kategori ini!");
      } else {
        updateKategori(text);
      }
    });
  }

  void addAnggaran(context) async {
    if (nomAnggaranC.text.isNotEmpty && kategoriC.isNotEmpty) {
      isLoading.value = true;
      try {
        String uid = auth.currentUser!.uid;
        kategoriCheck();
        String id = firestore.collection("users").doc().id;
        await firestore
            .collection("users")
            .doc(uid)
            .collection("anggaran")
            .doc(id)
            .set({
          "id": id,
          "kategori": kategoriC.value,
          "nominal": int.parse(nomAnggaranC.text.replaceAll('.', '')),
          "jenisAnggaran": jenisKategori,
          "nominalTerpakai": 0,
          "persentase": "0.0",
          "sisaLimit": int.parse(nomAnggaranC.text.replaceAll('.', '')),
          "createdAt": DateTime.now().toIso8601String(),
          "updatedAt": DateTime.now().toIso8601String(),
        });
        isLoading.value = false;

        kategoriC.value = "Pilih Kategori";
        nomAnggaranC.text = "0";

        con.totalNominalKategori();
        con.countAnggaranDetail(kategoriC.value);

        Navigator.pop(context);
      } catch (e) {
        isLoading.value = false;
        // print(e);
        Get.snackbar("TERJADI KESALAHAN", "Tidak dapat menambahkan data");
      }
    } else {
      Get.snackbar("TERJADI KESALAHAN", "Kategori dan nominal wajib diisi");
    }
  }
}
