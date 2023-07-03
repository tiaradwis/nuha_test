import 'dart:io';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:image_picker/image_picker.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/cashflow/controllers/cashflow_controller.dart';

class TransaksiController extends GetxController {
  final c = Get.find<CashflowController>();
  TextEditingController searchTransaksiC = TextEditingController();
  TextEditingController nominalTransaksiC = TextEditingController();
  TextEditingController namaTransaksiC = TextEditingController();
  TextEditingController deskripsiC = TextEditingController();

  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  var jenisC = "Pengeluaran".obs;
  var kategoriC = "Pilih Kategori".obs;
  var totalPendapatan = 0.obs;
  var totalPengeluaran = 0.obs;
  var tempSearch = [].obs; //list hasil search transaksi
  var kategoriStat = "".obs;
  var selectDate = DateTime.now().obs;
  String transaksiUrl = "";
  XFile? image;

  @override
  void onInit() {
    super.onInit();
    totalTransPendapatan();
    totalTransPengeluaran();
  }

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

  void totalTransPendapatan() async {
    totalPendapatan.value = 0;
    String uid = auth.currentUser!.uid;
    firestore
        .collection("users")
        .doc(uid)
        .collection("transaksi")
        .where("jenisTransaksi", isEqualTo: "Pendapatan")
        .get()
        .then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        int nominalTrans = doc.data()['nominal'];
        totalPendapatan += nominalTrans;
      }
      // print('Total nominal: $totalNominal');
    });
  }

  void totalTransPengeluaran() async {
    totalPengeluaran.value = 0;
    String uid = auth.currentUser!.uid;
    firestore
        .collection("users")
        .doc(uid)
        .collection("transaksi")
        .where("jenisTransaksi", isEqualTo: "Pengeluaran")
        .get()
        .then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        int nominalTrans = doc.data()['nominal'];
        totalPengeluaran += nominalTrans;
      }
      // print('Total nominal: $totalNominal');
    });
  }

  void searchTransaksi(String data) async {
    // print(data);
    String uid = auth.currentUser!.uid;

    if (data.isEmpty) {
      tempSearch.value = [];
    } else {
      var capitalize = data.capitalizeFirst;
      // print(capitalize);
      if (tempSearch.isEmpty && data.isNotEmpty) {
        CollectionReference transaksi =
            firestore.collection("users").doc(uid).collection("transaksi");
        final keyNameResult = await transaksi
            .where("namaTransaksi", isGreaterThanOrEqualTo: capitalize)
            .where("namaTransaksi", isLessThan: '${capitalize}z')
            .get();

        // print("Total data: ${keyNameResult.docs.length}");
        if (keyNameResult.docs.isNotEmpty) {
          tempSearch.value = [];
          for (int i = 0; i < keyNameResult.docs.length; i++) {
            tempSearch
                .add(keyNameResult.docs[i].data() as Map<String, dynamic>);
          }
          // print(tempSearch);
        }
      }
    }

    tempSearch.refresh();
    update();
  }

  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2024),
      cancelText: "BATAL",
      confirmText: "OK",
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: buttonColor1,
              onPrimary: backgroundColor1,
              onSurface: grey900,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: grey900,
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600)),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != selectDate.value) {
      selectDate.value = pickedDate;
    }
  }

  void resetImageTransaksi() async {
    image = null;
    update();
  }

  void updateImageTransaksi(String foto) async {
    image = null;
    update();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamSemuaTransaksi() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection("users")
        .doc(uid)
        .collection("transaksi")
        .orderBy("tanggalTransaksi", descending: true)
        .snapshots();
  }

  Future<Map<String, dynamic>?> getTransaksiById(String docId) async {
    try {
      String uid = auth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> doc = await firestore
          .collection("users")
          .doc(uid)
          .collection("transaksi")
          .doc(docId)
          .get();
      return doc.data();
    } catch (e) {
      // print(e);
      return null;
    }
  }

  void updateTransaksiById(context, String docId) async {
    isLoading.value = true;
    if (jenisC.isNotEmpty &&
        nominalTransaksiC.text.isNotEmpty &&
        kategoriC.isNotEmpty &&
        kategoriC.value != "Pilih Kategori" &&
        namaTransaksiC.text.isNotEmpty &&
        selectDate.toString().isNotEmpty) {
      String uid = auth.currentUser!.uid;

      if (image != null) {
        String ext = image!.name.split(".").last;
        await storage.ref(uid).child("$docId.$ext").putFile(File(image!.path));

        String urlTransaksi =
            await storage.ref(uid).child("$docId.$ext").getDownloadURL();

        transaksiUrl = urlTransaksi;
      }

      try {
        c.countAnggaranDetail(kategoriC.value);

        await firestore
            .collection("users")
            .doc(uid)
            .collection("transaksi")
            .doc(docId)
            .update({
          "jenisTransaksi": jenisC.value,
          "namaTransaksi": namaTransaksiC.text,
          "kategori": kategoriC.value,
          "nominal": int.parse(nominalTransaksiC.text.replaceAll('.', '')),
          "tanggalTransaksi": selectDate.value,
          "deskripsi": deskripsiC.text,
          "foto": transaksiUrl,
          "createdAt": DateTime.now().toIso8601String(),
          "updatedAt": DateTime.now().toIso8601String(),
        });
        isLoading.value = false;

        totalTransPendapatan();
        totalTransPengeluaran();

        // Get.back();
        Navigator.pop(context);
        successMsg("Data berhasil diubah.");
      } catch (e) {
        // print(e);
        isLoading.value = false;
        errMsg("Tidak dapat merubah data, coba lagi nanti!");
      }
    }
  }

  void deleteTransaksiById(context, String docId) async {
    isLoading.value = true;
    String kategoriValue = "";
    try {
      String uid = auth.currentUser!.uid;

      DocumentSnapshot<Map<String, dynamic>> doc = await firestore
          .collection("users")
          .doc(uid)
          .collection("transaksi")
          .doc(docId)
          .get();
      kategoriValue = doc.data()?["kategori"];

      c.countAnggaranDetail(kategoriValue);

      await firestore
          .collection("users")
          .doc(uid)
          .collection("transaksi")
          .doc(docId)
          .delete();
      isLoading.value = false;

      totalTransPendapatan();
      totalTransPengeluaran();

      Get.back();
      Navigator.pop(context);

      successMsg("Data berhasil kami hapus dari database.");
    } catch (e) {
      // print(e);
      isLoading.value = false;
      errMsg("Tidak dapat menghapus data, coba lagi nanti!");
    }
  }
}
