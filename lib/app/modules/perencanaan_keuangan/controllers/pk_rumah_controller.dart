import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/perencanaan_keuangan_view.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/rs_rumah_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import '../controllers/perencanaan_keuangan_controller.dart';

class PkRumahController extends GetxController {
  TextEditingController nomRumah = TextEditingController();
  TextEditingController tahunTercapai = TextEditingController();
  TextEditingController nomDanaTersedia = TextEditingController();
  TextEditingController nomDanaDisisihkan = TextEditingController();
  TextEditingController margin = TextEditingController();

  final con = Get.find<PerencanaanKeuanganController>();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  var caraPembayaran = "Pilih Cara Pembayaran".obs;
  var statusStat = "".obs;

  double persentage = 0.0;
  double realPersentage = 0.0;
  double perkiraanHarga = 0; //nomRumah*0.05
  int nomSisa = 0;
  double bulan = 0.0;
  double tabunganPerbulan = 0.0;
  var danaStat = "";

  double bungaTahunan = 0.0;
  int angsuranBulanan = 0;
  double biayaLain = 0;

  int penghasilan30 = 0;
  int penghasilan40 = 0;

  RxBool isLoading = false.obs;

  void updateStatus(value) {
    caraPembayaran.value = value;
    statusStat.value = "choosen";
  }

  void countCash(context) async {
    perkiraanHarga = double.parse(nomRumah.text.replaceAll(".", ""));

    for (int i = 1; i < double.parse(tahunTercapai.text); i++) {
      perkiraanHarga += perkiraanHarga * 0.05;
    }

    nomSisa = perkiraanHarga.toInt() -
        int.parse(nomDanaTersedia.text.replaceAll(".", ""));

    bulan = double.parse(tahunTercapai.text) * 12;

    tabunganPerbulan = perkiraanHarga.toDouble() / bulan;

    if (int.parse(nomDanaDisisihkan.text.replaceAll(".", "")) >
        tabunganPerbulan) {
      danaStat = "dapat tercapai";
    } else {
      danaStat = "tidak akan tercapai";
    }

    persentage =
        (int.parse(nomDanaTersedia.text.replaceAll(".", "")) / perkiraanHarga);

    realPersentage = persentage;
    if (persentage < 0.1) {
      persentage = 0.1;
    }

    Get.to(RsRumahView());
  }

  void countKPRMurabahah(context) async {
    nomSisa = int.parse(nomRumah.text.replaceAll(".", "")) -
        int.parse(nomDanaTersedia.text.replaceAll(".", ""));

    persentage = (int.parse(nomDanaTersedia.text.replaceAll(".", "")) /
        int.parse(nomRumah.text.replaceAll(".", "")));

    bungaTahunan = double.parse(margin.text) / 100;

    bulan = double.parse(tahunTercapai.text) * 12;

    angsuranBulanan =
        ((nomSisa * (bungaTahunan * int.parse(tahunTercapai.text)) + nomSisa) /
                bulan)
            .round();

    penghasilan30 = angsuranBulanan * (100 ~/ 30).toInt();

    penghasilan40 = angsuranBulanan * (100 ~/ 40).toInt();

    Get.to(RsRumahView());
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
          "kategori": "Dana Rumah Impian",
          "nominal": perkiraanHarga != 0
              ? perkiraanHarga
              : int.parse(nomRumah.text.replaceAll(".", "")),
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
