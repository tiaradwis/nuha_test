import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:nuha/app/modules/cashflow/controllers/laporankeuangan_controller.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class CashflowController extends GetxController {
  LaporankeuanganController laporankeuanganController =
      Get.find<LaporankeuanganController>();

  TextEditingController nomAnggaranC = TextEditingController();
  TextEditingController searchAnggaranC = TextEditingController();
  RxBool isLoading = false.obs;

  late TabController tabController;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  var jenisC = "Pengeluaran".obs;
  var kategoriC = "Pilih Kategori".obs;
  var kategoriStat = "".obs;
  var selectDate = DateTime.now().obs;
  var currentTab = 0.obs;
  var totalNominal = 0.obs;
  var totalPendapatan = 0.obs;
  var totalPengeluaran = 0.obs;
  var angTerpakai = 0.obs;
  var sisaAnggaran = 0.obs;
  var persenAnggaran = "0.0".obs;

  var queryAwal = [].obs;
  var transaksiList = [].obs;

  String jenisKategori = "";
  String transaksiUrl = "";

  final GroupedItemScrollController itemScrollController =
      GroupedItemScrollController();

  @override
  void onInit() {
    super.onInit();
    totalNominalKategori();
    countAnggaranTerpakai();
  }

  void changeTabIndex(int index) {
    currentTab.value = index;
    // print(currentTab);
    update();
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

  Stream<QuerySnapshot<Map<String, dynamic>>> streamSemuaAnggaran() async* {
    String uid = auth.currentUser!.uid;
    if (currentTab.value == 0) {
      yield* firestore
          .collection("users")
          .doc(uid)
          .collection("anggaran")
          .snapshots();
    } else if (currentTab.value == 1) {
      yield* firestore
          .collection("users")
          .doc(uid)
          .collection("anggaran")
          .where("jenisAnggaran", isEqualTo: "Umum")
          .snapshots();
    } else if (currentTab.value == 2) {
      yield* firestore
          .collection("users")
          .doc(uid)
          .collection("anggaran")
          .where("jenisAnggaran", isEqualTo: "Biaya Hidup")
          .snapshots();
    } else {
      yield* firestore
          .collection("users")
          .doc(uid)
          .collection("anggaran")
          .where("jenisAnggaran", isEqualTo: "Lainnya")
          .snapshots();
    }
  }

  void countAnggaranDetail(String kategori) async {
    String uid = auth.currentUser!.uid;
    int nomTotal = 0;
    String idData = "";
    int nominal = 0;
    int sisaLimit = 0;
    String persentaseLimit = "";

    firestore
        .collection("users")
        .doc(uid)
        .collection("transaksi")
        .where("kategori", isEqualTo: kategori)
        .get()
        .then((value) {
      for (var doc in value.docs) {
        int nominal = doc.data()['nominal'];
        nomTotal += nominal;
      }

      if (nomTotal > 0) {
        firestore
            .collection("users")
            .doc(uid)
            .collection("anggaran")
            .where("kategori", isEqualTo: kategori)
            .get()
            .then((value) {
          if (value.docs.isNotEmpty) {
            idData = value.docs[0].data()["id"];
            nominal = value.docs[0].data()["nominal"];

            sisaLimit = nominal - nomTotal;
            persentaseLimit = (nomTotal / nominal).toStringAsFixed(2);

            firestore
                .collection("users")
                .doc(uid)
                .collection("anggaran")
                .doc(idData)
                .update({
              "nominalTerpakai": nomTotal,
              "sisaLimit": sisaLimit,
              "persentase": persentaseLimit,
            });
          }
        });
      }

      firestore
          .collection("users")
          .doc(uid)
          .collection("anggaran")
          .where("kategori", isEqualTo: kategori)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          idData = value.docs[0].data()["id"];
          nominal = value.docs[0].data()["nominal"];

          sisaLimit = nominal - nomTotal;
          persentaseLimit = (nomTotal / nominal).toStringAsFixed(2);

          firestore
              .collection("users")
              .doc(uid)
              .collection("anggaran")
              .doc(idData)
              .update({
            "nominalTerpakai": nomTotal,
            "sisaLimit": sisaLimit,
            "persentase": persentaseLimit,
          });
        }
      });
    });

    countAnggaranTerpakai();
  }

  void totalNominalKategori() async {
    totalNominal.value = 0;
    String uid = auth.currentUser!.uid;
    firestore
        .collection("users")
        .doc(uid)
        .collection("anggaran")
        .get()
        .then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        int nominal = doc.data()['nominal'];
        totalNominal += nominal;
      }

      countAnggaranSisa();
    });
  }

  void countAnggaranTerpakai() async {
    angTerpakai.value = 0;
    String uid = auth.currentUser!.uid;
    firestore
        .collection("users")
        .doc(uid)
        .collection("anggaran")
        .get()
        .then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        int nominalTerpakai = doc.data()['nominalTerpakai'];
        angTerpakai += nominalTerpakai;
      }
      laporankeuanganController.getDataPengeluaran();
      laporankeuanganController.getDataMasukKeluar();
      laporankeuanganController.getDataPemasukan();
      countAnggaranSisa();
    });
  }

  void countAnggaranSisa() async {
    sisaAnggaran.value = totalNominal.value - angTerpakai.value;
    persenAnggaran.value =
        (angTerpakai.value / totalNominal.value).toStringAsFixed(2);
  }

  void searchAnggaran(String data) async {
    // print(data);
    String uid = auth.currentUser!.uid;

    if (data.isEmpty) {
      queryAwal.value = [];
    } else {
      var capitalize = data.capitalizeFirst;
      // print(capitalize);
      if (queryAwal.isEmpty && data.isNotEmpty) {
        CollectionReference anggaran =
            firestore.collection("users").doc(uid).collection("anggaran");
        final keyNameResult = await anggaran
            .where("kategori", isGreaterThanOrEqualTo: capitalize)
            .where("kategori", isLessThan: '${capitalize}z')
            .get();

        // print("Total data: ${keyNameResult.docs.length}");
        if (keyNameResult.docs.isNotEmpty) {
          queryAwal.value = [];
          for (int i = 0; i < keyNameResult.docs.length; i++) {
            queryAwal.add(keyNameResult.docs[i].data() as Map<String, dynamic>);
          }
          // print(queryAwal);
        }
      }
    }

    queryAwal.refresh();
    update();
  }
}
