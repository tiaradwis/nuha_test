import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';

class ResetPasswordController extends GetxController {
  TextEditingController emailC = TextEditingController();
  RxBool isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;

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

  void resetPassword() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        auth.sendPasswordResetEmail(email: emailC.text);
        isLoading.value = false;
        Get.back();
        successMsg('Kami telah kirim link reset password ke email anda');
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        errMsg(e.code);
      } catch (e) {
        isLoading.value = false;
        errMsg('Email tidak tersedia');
      }
    } else {
      errMsg('Email harus diisi');
    }
  }
}
