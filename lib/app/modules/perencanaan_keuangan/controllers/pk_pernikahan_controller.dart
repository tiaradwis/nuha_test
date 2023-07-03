import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/perencanaan_keuangan_view.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/rs_pernikahan_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import '../controllers/perencanaan_keuangan_controller.dart';

class PkPernikahanController extends GetxController {
  TextEditingController namaPasangan = TextEditingController();
  TextEditingController nomBiaya = TextEditingController();
  TextEditingController bulanTercapai = TextEditingController();
  TextEditingController nomDanaTersedia = TextEditingController();
  TextEditingController nomDanaDisisihkan = TextEditingController();

  final con = Get.find<PerencanaanKeuanganController>();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  double danaPernikahan = 0.0;
  int nomSisa = 0;
  double nomPerbulan = 0.0;
  double persentage = 0.0;
  double tahun = 0.0;
  var danaStat = "";
  double realPersentage = 0.0;

  RxBool isLoading = false.obs;

  void countDana(context) async {
    tahun = int.parse(bulanTercapai.text) / 12;

    danaPernikahan = double.parse(nomBiaya.text.replaceAll(".", ""));

    for (int i = 1; i < tahun; i++) {
      danaPernikahan += danaPernikahan * 0.1;
    }

    nomSisa = danaPernikahan.toInt() -
        int.parse(nomDanaTersedia.text.replaceAll(".", ""));

    nomPerbulan = danaPernikahan.toInt() / int.parse(bulanTercapai.text);

    if (int.parse(nomDanaDisisihkan.text.replaceAll(".", "")) > nomPerbulan) {
      danaStat = "dapat tercapai";
    } else {
      danaStat = "tidak akan tercapai";
    }

    persentage =
        (int.parse(nomDanaTersedia.text.replaceAll(".", "")) / danaPernikahan);

    realPersentage = persentage;
    if (persentage < 0.1) {
      persentage = 0.1;
    } else if (persentage > 1.0) {
      persentage = 1.0;
    }
    Get.to(RsPernikahanView());
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
          "kategori": "Dana Pernikahan",
          "nominal": danaPernikahan,
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
