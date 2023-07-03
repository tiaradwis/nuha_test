import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/perencanaan_keuangan_view.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/rs_darurat_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import '../controllers/perencanaan_keuangan_controller.dart';

class PkDaruratController extends GetxController {
  TextEditingController namaDana = TextEditingController();
  TextEditingController nomPengeluaran = TextEditingController();
  TextEditingController bulanTercapai = TextEditingController();
  TextEditingController nomDanaTersedia = TextEditingController();
  TextEditingController nomDanaDisisihkan = TextEditingController();

  final con = Get.find<PerencanaanKeuanganController>();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  final textValidation = TextEditingController();
  RxBool isLoading = false.obs;

  var statusPernikahan = "Pilih Status Pernikahan".obs;
  var statusStat = "".obs;
  var danaStat = "";
  int danaDarurat = 0;
  int nomSisa = 0;
  double nomPerbulan = 0.0;
  double totalDanaSisihkan = 0.0;
  double persentage = 0.0;
  double realPersentage = 0.0;

  void updateStatus(value) {
    statusPernikahan.value = value;
    statusStat.value = "choosen";
  }

  void countDana(context) async {
    if (statusPernikahan.value == "Belum Menikah") {
      danaDarurat = 3 * int.parse(nomPengeluaran.text.replaceAll(".", ""));
    } else if (statusPernikahan.value == "Sudah Menikah") {
      danaDarurat = 6 * int.parse(nomPengeluaran.text.replaceAll(".", ""));
    } else if (statusPernikahan.value == "Sudah Menikah dan Memiliki Anak") {
      danaDarurat = 12 * int.parse(nomPengeluaran.text.replaceAll(".", ""));
    } else {
      danaDarurat = 0;
    }

    nomSisa = danaDarurat - int.parse(nomDanaTersedia.text.replaceAll(".", ""));
    nomPerbulan = nomSisa / int.parse(bulanTercapai.text);

    if (int.parse(nomDanaDisisihkan.text.replaceAll(".", "")) > nomPerbulan) {
      danaStat = "dapat tercapai";
    } else {
      danaStat = "tidak akan tercapai";
    }

    persentage =
        (int.parse(nomDanaTersedia.text.replaceAll(".", "")) / danaDarurat);

    realPersentage = persentage;

    if (persentage > 1.0) {
      persentage = 1.0;
    } else if (persentage < 0.1) {
      persentage = 0.1;
    }

    Get.to(RsDaruratView());
  }

  void saveData(context) async {
    if (nomDanaTersedia.text.isNotEmpty) {
      isLoading.value = true;
      try {
        String uid = auth.currentUser!.uid;
        String id = firestore.collection("users").doc().id;

        await firestore
            .collection("users")
            .doc(uid)
            .collection("anggaran")
            .doc(id)
            .set({
          "id": id,
          "kategori": "Dana Darurat",
          "nominal": danaDarurat,
          "jenisAnggaran": "Lainnya",
          "nominalTerpakai":
              int.parse(nomDanaTersedia.text.replaceAll(".", "")),
          "persentase":
              double.parse(realPersentage.toStringAsFixed(2)).toString(),
          "sisaLimit": nomSisa,
          "createdAt": DateTime.now().toIso8601String(),
          "updatedAt": DateTime.now().toIso8601String(),
        });
        isLoading.value = false;

        Get.to(const PerencanaanKeuanganView());
      } catch (e) {
        isLoading.value = false;
        // print(e);
        con.errMsg("Tidak dapat menambahkan data!");
      }
    } else {
      con.errMsg("Seluruh data wajib diisi");
    }
  }
}
