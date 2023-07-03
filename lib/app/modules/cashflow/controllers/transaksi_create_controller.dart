import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:nuha/app/modules/cashflow/controllers/cashflow_controller.dart';
import 'package:nuha/app/modules/cashflow/controllers/transaksi_controller.dart';

class TransaksiCreateController extends GetxController {
  final c = Get.find<TransaksiController>();
  final con = Get.find<CashflowController>();

  TextEditingController nominalTransaksiC = TextEditingController();
  TextEditingController namaTransaksiC = TextEditingController();
  TextEditingController deskripsiC = TextEditingController();
  RxBool isLoading = false.obs;

  var jenisC = "Pengeluaran".obs;
  var kategoriC = "Pilih Kategori".obs;
  var kategoriStat = "".obs;
  var selectDate = DateTime.now().obs;
  String transaksiUrl = "";
  XFile? image;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  @override
  void onInit() {
    super.onInit();
  }

  void resetForm() {
    nominalTransaksiC.clear();
    kategoriC.value = "Pilih Kategori";
    namaTransaksiC.clear();
    deskripsiC.clear();
    image = null;
  }

  void updateToPendapatan() {
    jenisC.value = "Pendapatan";
    kategoriC.value = "Pilih Kategori";
    kategoriStat.value = "";
    Get.back();
  }

  void updateToPengeluaran() {
    jenisC.value = "Pengeluaran";
    kategoriC.value = "Pilih Kategori";
    kategoriStat.value = "";

    Get.back();
  }

  void updateKategori(text) {
    kategoriC.value = text;
    kategoriStat.value = "choosen";

    Get.back();
  }

  pickImageTransaksi(String pickCam) async {
    final ImagePicker picker = ImagePicker();
    if (pickCam == "kamera") {
      image = await picker.pickImage(source: ImageSource.camera);
    } else {
      image = await picker.pickImage(source: ImageSource.gallery);
    }

    if (image != null) {
      update();
      Get.back();
    }
  }

  void resetImageTransaksi() async {
    image = null;
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

  void addTransaksi(context) async {
    if (jenisC.isNotEmpty &&
        nominalTransaksiC.text.isNotEmpty &&
        kategoriC.isNotEmpty &&
        kategoriC.value != "Pilih Kategori" &&
        namaTransaksiC.text.isNotEmpty &&
        selectDate.toString().isNotEmpty) {
      isLoading.value = true;
      String uid = auth.currentUser!.uid;
      String random = DateTime.now().toIso8601String();
      String id = firestore.collection("users").doc().id;

      if (image != null) {
        String ext = image!.name.split(".").last;
        await storage
            .ref(uid)
            .child("tr$random.$ext")
            .putFile(File(image!.path));

        String urlTransaksi =
            await storage.ref(uid).child("tr$random.$ext").getDownloadURL();

        transaksiUrl = urlTransaksi;
      }

      try {
        con.kategoriCheck();
        con.countAnggaranDetail(kategoriC.value);
        await firestore
            .collection("users")
            .doc(uid)
            .collection("transaksi")
            .doc(id)
            .set({
          "id": id,
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

        c.totalTransPendapatan();
        c.totalTransPengeluaran();
        con.countAnggaranDetail(kategoriC.value);
        resetForm();

        Navigator.pop(context);
      } catch (e) {
        isLoading.value = false;
        // print(e);
        c.errMsg("Tidak dapat menambahkan data");
      }
    } else {
      c.errMsg("Tidak dapat menambahkan data");
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamData() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection("users")
        .doc(uid)
        .collection("anggaran")
        .where("kategori", isGreaterThanOrEqualTo: "Dana")
        .where("kategori", isLessThan: 'Danaz')
        .snapshots();
  }
}
