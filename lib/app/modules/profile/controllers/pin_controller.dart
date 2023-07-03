import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'package:pinput/pinput.dart';

class PinController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  final pinController = TextEditingController();
  final newpinController = TextEditingController();
  final confirmNewPinController = TextEditingController();
  final authPinController = TextEditingController();

  final pinNode = FocusNode();
  final newPinNode = FocusNode();
  final confirmNewPinNode = FocusNode();
  final authPinNode = FocusNode();

  final formKey = GlobalKey<FormState>();
  final newFormKey = GlobalKey<FormState>();
  final conFormKey = GlobalKey<FormState>();
  final authPinKey = GlobalKey<FormState>();

  var focusedBorderColor = buttonColor1;
  var fillColor = const Color.fromRGBO(243, 246, 249, 0);
  var borderColor = const Color.fromRGBO(23, 171, 144, 0.4);
  final defaultPinTheme = PinTheme(
    width: 52,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
      border: Border.all(color: buttonColor1.withOpacity(0.5)),
    ),
  );

  RxString myPIN = ''.obs;

  @override
  void onInit() {
    getUserPin();
    super.onInit();
  }

  @override
  void onClose() {
    pinController.dispose();
    pinNode.dispose();
    super.dispose();
  }

  Future<void> getUserPin() async {
    try {
      var user = auth.currentUser!.uid;

      final DocumentSnapshot<Map<String, dynamic>> dataDoc =
          await FirebaseFirestore.instance.collection('users').doc(user).get();

      if (dataDoc.exists) {
        myPIN.value = dataDoc.data()!['pin'];
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('Data user tidak ditemukan.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('Gagal mengambil data.')),
      );
    }
  }

  Future<void> createUserPin(String newPin) async {
    try {
      var user = auth.currentUser!.uid;

      await FirebaseFirestore.instance.collection('users').doc(user).update({
        'pin': confirmNewPinController.text,
      });

      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('Pin kamu berhasil dibuat.')),
      );

      Get.offAllNamed(Routes.NAVBAR);
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('Gagal mengambil data.')),
      );
    }
  }
}
