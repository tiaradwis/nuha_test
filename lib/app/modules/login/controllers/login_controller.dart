// ignore_for_file: avoid_print, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/routes/app_pages.dart';

class LoginController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  RxBool isHidden = true.obs;
  RxBool isLoading = false.obs;
  RxBool rememeberMe = false.obs;
  final box = GetStorage();
  RxBool isLoadingG = false.obs;

  //Google Sign In
  final GoogleSignIn googleSignIn = GoogleSignIn();

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

  void login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      try {
        isLoading.value = true;
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );

        isLoading.value = false;

        if (userCredential.user!.emailVerified == true) {
          if (box.read("rememberMe") != null) {
            await box.remove("rememberMe");
          }
          if (rememeberMe.isTrue) {
            await box.write("rememberMe", {
              "email": emailC.text,
              "pass": passC.text,
            });
          }

          final DocumentSnapshot<Map<String, dynamic>> userDoc = await firestore
              .collection('users')
              .doc(auth.currentUser!.uid)
              .get();
          var pinCheck = userDoc.data()!['pin'];

          if (pinCheck == '') {
            Get.toNamed(Routes.CREATE_PIN);
          } else {
            Get.toNamed(Routes.AUTH_PIN, arguments: Routes.NAVBAR);
          }
        } else {
          print('User belum terverifikasi');
          Get.defaultDialog(
            title: "Belum Terverifikasi",
            middleText: "Apakah anda ingin mengirim email verifikasi?",
            middleTextStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
            actions: [
              OutlinedButton(
                onPressed: () => Get.back(),
                child: const Text("Tidak"),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await userCredential.user!.sendEmailVerification();
                    Get.back();
                    successMsg('Verifikasi email berhasil dikirim');
                  } catch (e) {
                    Get.back();
                    errMsg('Terlalu banyak permintaan verifikasi email');
                    print(e);
                  }
                },
                child: const Text("Kirim"),
              ),
            ],
          );
        }
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          errMsg('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          errMsg('Wrong password provided for that user.');
        }
      }
    } else {
      errMsg('Email dan Password tidak boleh kosong');
    }
  }

  void registerWithGoogle() async {
    try {
      isLoadingG.value = true;
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );

      isLoadingG.value = false;
      await auth.signInWithCredential(credential);
      DocumentSnapshot<Map<String, dynamic>> query =
          await firestore.collection('users').doc(auth.currentUser!.uid).get();

      if (!query.exists) {
        await firestore.collection("users").doc(auth.currentUser!.uid).set({
          "name": auth.currentUser!.displayName,
          "email": auth.currentUser!.email,
          "uid": auth.currentUser!.uid,
          "phone": "",
          "tgl_lahir": "",
          "pekerjaan": "",
          "pin": "",
          "created_at": DateTime.now().toIso8601String(),
        });
      }
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await firestore.collection('users').doc(auth.currentUser!.uid).get();
      var pinCheck = userDoc.data()!['pin'];

      if (pinCheck == '') {
        Get.toNamed(Routes.CREATE_PIN);
      } else {
        Get.toNamed(Routes.AUTH_PIN, arguments: Routes.NAVBAR);
      }
    } on FirebaseAuthException catch (e) {
      isLoadingG.value = false;
      if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        errMsg('This account exists with different credential.');
      }
    } catch (e) {
      print(e);
    }
  }
}
