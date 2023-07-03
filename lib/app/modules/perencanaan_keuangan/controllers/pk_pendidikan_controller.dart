import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/perencanaan_keuangan_view.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/rs_pendidikan_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import '../controllers/perencanaan_keuangan_controller.dart';

class PkPendidikanController extends GetxController {
  TextEditingController namaAnak = TextEditingController();
  TextEditingController umurAnak = TextEditingController();
  TextEditingController umurAnakMasuk = TextEditingController();
  TextEditingController uangPangkal = TextEditingController();
  TextEditingController uangSPP = TextEditingController();
  TextEditingController nomDanaSisih = TextEditingController();
  TextEditingController lamaPendidikan = TextEditingController();
  TextEditingController nomDanaTersedia = TextEditingController();

  final con = Get.find<PerencanaanKeuanganController>();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  RxBool isLoading = false.obs;

  int totalDana = 0;
  double margin = 0.1;
  int jarakTahun = 0;
  int totalSPP = 0;
  double danaSekolah = 0.0;
  double persentage = 0.0;
  double realPersentage = 0.0;
  double nomSisa = 0.0;
  double nomPerbulan = 0.0;
  double bulanTercapai = 0;
  var danaStat = "";

  void countDana(context) async {
    jarakTahun = int.parse(umurAnakMasuk.text) - int.parse(umurAnak.text);

    totalSPP = jarakTahun * 12 * int.parse(uangSPP.text.replaceAll(".", ""));

    danaSekolah = totalSPP + double.parse(uangPangkal.text.replaceAll(".", ""));

    for (int i = 1; i < jarakTahun; i++) {
      danaSekolah += danaSekolah * margin;
    }

    persentage =
        double.parse(nomDanaTersedia.text.replaceAll(".", "")) / danaSekolah;

    realPersentage = persentage;
    nomSisa =
        danaSekolah - double.parse(nomDanaTersedia.text.replaceAll(".", ""));

    bulanTercapai = jarakTahun * 12;
    nomPerbulan = nomSisa / bulanTercapai;

    if (double.parse(nomDanaSisih.text.replaceAll(".", "")) > nomPerbulan) {
      danaStat = "dapat tercapai";
    } else {
      danaStat = "tidak dapat dicapai";
    }

    if (persentage > 1.0) {
      persentage = 1.0;
    } else if (persentage < 0.1) {
      persentage = 0.1;
    }

    Get.to(RsPendidikanView());
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
          "kategori": "Dana Pendidikan",
          "nominal": danaSekolah,
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
