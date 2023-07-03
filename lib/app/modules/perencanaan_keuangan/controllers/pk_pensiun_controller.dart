import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/perencanaan_keuangan_view.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/rs_pensiun_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import '../controllers/perencanaan_keuangan_controller.dart';

class PkPensiunController extends GetxController {
  TextEditingController umurSaatIni = TextEditingController();
  TextEditingController umurPensiun = TextEditingController();
  TextEditingController nomDanaTersedia = TextEditingController();
  TextEditingController nomDanaDisisihkan = TextEditingController();
  TextEditingController biayaHidup = TextEditingController();

  RxBool isLoading = false.obs;

  final con = Get.find<PerencanaanKeuanganController>();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  double danaPensiun = 0;
  int totalBulan = 0;
  int jarakTahun = 0;
  int nomSisa = 0;
  int nomPerbulan = 0;
  var danaStat = "";
  double persentage = 0.0;
  double realPersentage = 0.0;

  void countDana(context) async {
    totalBulan =
        (int.parse(umurPensiun.text) - int.parse(umurSaatIni.text)) * 12;

    jarakTahun = 80 - int.parse(umurPensiun.text);

    danaPensiun =
        double.parse(biayaHidup.text.replaceAll(".", "")) * 12 * jarakTahun;

    for (int i = 1; i < jarakTahun; i++) {
      danaPensiun += danaPensiun * 0.05;
    }

    nomSisa = danaPensiun.toInt() -
        int.parse(nomDanaTersedia.text.replaceAll(".", ""));

    nomPerbulan = (nomSisa / totalBulan).round();

    if (int.parse(nomDanaDisisihkan.text.replaceAll(".", "")) > nomPerbulan) {
      danaStat = "dapat tercapai";
    } else {
      danaStat = "tidak akan tercapai";
    }

    persentage =
        (int.parse(nomDanaTersedia.text.replaceAll(".", "")) / danaPensiun);

    realPersentage = persentage;
    if (persentage > 1.0) {
      persentage = 1.0;
    } else if (persentage < 0.1) {
      persentage = 0.1;
    }

    Get.to(() => RsPensiunView());
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
          "kategori": "Dana Pensiun",
          "nominal": danaPensiun,
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
