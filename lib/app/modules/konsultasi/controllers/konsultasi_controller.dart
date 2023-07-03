import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nuha/app/modules/konsultasi/models/consultant_model.dart';

class KonsultasiController extends GetxController {
  RxBool isSelected = false.obs;
  RxInt tag = RxInt(1);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<Consultant> consultantList = <Consultant>[].obs;

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting('id', null);
  }

  Future<List<Consultant>> getAllConsultant() async {
    try {
      QuerySnapshot consultantData =
          await firestore.collection('consultant').get();

      consultantList.clear();

      consultantList.value = consultantData.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        Consultant consultant = Consultant(
          consultantId: doc.id,
          name: data['name'],
          category: data['category'],
          description: data['description'],
          imageUrl: data['imageUrl'],
          lastEducation: data['lastEducation'],
          location: data['location'],
          price: data['price'].toString(),
          sertificationId: data['sertificationId'],
          isAvailable: data['isAvailable'],
        );

        return consultant;
      }).toList();

      return consultantList;
    } catch (e) {
      print(e);
      return consultantList;
    }
  }

  Future<void> getConsultantDanaPensiun() async {
    try {
      QuerySnapshot consultantData = await firestore
          .collection('consultant')
          .where('category', isEqualTo: 'Dana Pensiun')
          .get();

      consultantList.clear();

      consultantList.value = consultantData.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        Consultant consultant = Consultant(
          consultantId: doc.id,
          name: data['name'],
          category: data['category'],
          description: data['description'],
          imageUrl: data['imageUrl'],
          lastEducation: data['lastEducation'],
          location: data['location'],
          price: data['price'].toString(),
          sertificationId: data['sertificationId'],
          isAvailable: data['isAvailable'],
        );

        return consultant;
      }).toList();
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('$e')),
      );
    }
  }

  Future<void> getConsultantPajak() async {
    try {
      QuerySnapshot consultantData = await firestore
          .collection('consultant')
          .where('category', isEqualTo: 'Pajak')
          .get();

      consultantList.clear();

      consultantList.value = consultantData.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        Consultant consultant = Consultant(
          consultantId: doc.id,
          name: data['name'],
          category: data['category'],
          description: data['description'],
          imageUrl: data['imageUrl'],
          lastEducation: data['lastEducation'],
          location: data['location'],
          price: data['price'].toString(),
          sertificationId: data['sertificationId'],
          isAvailable: data['isAvailable'],
        );

        return consultant;
      }).toList();
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('$e')),
      );
    }
  }

  Future<void> getConsultantPerencanaan() async {
    try {
      QuerySnapshot consultantData = await firestore
          .collection('consultant')
          .where('category', isEqualTo: 'Perencanaan Keuangan')
          .get();

      consultantList.clear();

      consultantList.value = consultantData.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        Consultant consultant = Consultant(
          consultantId: doc.id,
          name: data['name'],
          category: data['category'],
          description: data['description'],
          imageUrl: data['imageUrl'],
          lastEducation: data['lastEducation'],
          location: data['location'],
          price: data['price'].toString(),
          sertificationId: data['sertificationId'],
          isAvailable: data['isAvailable'],
        );

        return consultant;
      }).toList();
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('$e')),
      );
    }
  }

  Future<void> getConsultantReviewKeuangan() async {
    try {
      QuerySnapshot consultantData = await firestore
          .collection('consultant')
          .where('category', isEqualTo: 'Review Keuangan')
          .get();

      consultantList.clear();

      consultantList.value = consultantData.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        Consultant consultant = Consultant(
          consultantId: doc.id,
          name: data['name'],
          category: data['category'],
          description: data['description'],
          imageUrl: data['imageUrl'],
          lastEducation: data['lastEducation'],
          location: data['location'],
          price: data['price'].toString(),
          sertificationId: data['sertificationId'],
          isAvailable: data['isAvailable'],
        );

        return consultant;
      }).toList();
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('$e')),
      );
    }
  }
}
