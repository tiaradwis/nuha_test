import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPinController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool oldPIN = true.obs;
  RxBool newPIN = true.obs;
  RxBool confirmNewPIN = true.obs;
  TextEditingController oldPINC = TextEditingController();
  TextEditingController newPINC = TextEditingController();
  TextEditingController conNewPINC = TextEditingController();

  Future<void> updatePIN() async {
    if (oldPINC.text.isNotEmpty &&
        newPINC.text.isNotEmpty &&
        conNewPINC.text.isNotEmpty) {
      isLoading.value = true;
      final user = FirebaseAuth.instance.currentUser;

      if (oldPINC.text.length == 6 &&
          newPINC.text.length == 6 &&
          conNewPINC.text.length == 6) {
        if (newPINC.text == conNewPINC.text) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user!.uid)
              .update({
            'pin': newPINC.text,
          });
          oldPINC.clear();
          newPINC.clear();
          conNewPINC.clear();

          isLoading.value = false;

          ScaffoldMessenger.of(Get.context!).showSnackBar(
            const SnackBar(content: Text('Ubah PIN berhasil')),
          );
        } else {
          isLoading.value = false;
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            const SnackBar(content: Text('Konfirmasi Pin tidak cocok.')),
          );
        }
      } else {
        isLoading.value = false;
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('PIN harus 6 karakter angka')),
        );
      }
    } else {
      isLoading.value = false;
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('Data tidak boleh kosong.')),
      );
    }
  }
}
