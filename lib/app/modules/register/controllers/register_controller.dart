// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController konfirpassC = TextEditingController();
  RxBool isHiddenPass = true.obs;
  RxBool isHiddenConfirmPass = true.obs;
  RxBool isLoading = false.obs;
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

  void register() async {
    if (emailC.text.isNotEmpty &&
        passC.text.isNotEmpty &&
        nameC.text.isNotEmpty) {
      if (passC.text == konfirpassC.text) {
        try {
          isLoading.value = true;
          // ignore: unused_local_variable
          UserCredential userCredential =
              await auth.createUserWithEmailAndPassword(
            email: emailC.text,
            password: passC.text,
          );

          isLoading.value = false;
          //email verification
          await userCredential.user!.sendEmailVerification();
          //simpan data user di firestore
          await firestore
              .collection("users")
              .doc(userCredential.user!.uid)
              .set({
            "name": nameC.text,
            "email": emailC.text,
            "uid": userCredential.user!.uid,
            "phone": "",
            "tgl_lahir": "",
            "pekerjaan": "",
            "pin": "",
            "created_at": DateTime.now().toIso8601String(),
          });
          Get.offAllNamed(Routes.LOGIN);
          successMsg('Silahkan verifikasi email anda');
        } on FirebaseAuthException catch (e) {
          isLoading.value = false;
          if (e.code == 'weak-password') {
            errMsg('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            errMsg('The account already exists for that email.');
          }
        } catch (e) {
          print(e);
        }
      } else {
        errMsg("Konfirmasi password tidak cocok!");
      }
    } else {
      errMsg("Semua data tidak boleh kosong!");
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
