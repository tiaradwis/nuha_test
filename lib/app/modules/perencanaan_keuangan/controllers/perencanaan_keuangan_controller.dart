import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:nuha/mobile.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'package:screenshot/screenshot.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;

class PerencanaanKeuanganController extends GetxController {
  ScreenshotController screenshotController = ScreenshotController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

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

  Future<void> getPdf(Uint8List capturedImage, String name) async {
    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // The loading indicator
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('File sedang dibuat...',
                      style:
                          Theme.of(Get.context!).textTheme.bodySmall!.copyWith(
                                color: grey900,
                              ))
                ],
              ),
            ),
          );
        });

    PdfDocument document = PdfDocument();

    final page = document.pages.add();

    document.pageSettings.size = PdfPageSize.a4;

    const pageSize = PdfPageSize.a4;

    final time = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    //Draw the image
    page.graphics.drawImage(PdfBitmap(capturedImage),
        Rect.fromLTWH(20, 0, pageSize.width - 120, pageSize.height - 250));

    page.graphics.drawImage(PdfBitmap(await readImageData('NUHA.png')),
        const Rect.fromLTWH(20, 690, 200, 50));

    drawFooter(page, pageSize);

    //Save the document
    List<int> bytes = await document.save();

    await Future.delayed(const Duration(seconds: 5));

    Get.back();

    saveAndLaunchFile(bytes, '${name}_$time.pdf');
    document.dispose();
  }

  void drawFooter(PdfPage page, Size pageSize) async {
    final time = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());

    final PdfPen linePen =
        PdfPen(PdfColor(27, 30, 35), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 170),
        Offset(pageSize.width, pageSize.height - 170));

    String footerContent =
        // ignore: leading_newlines_in_multiline_strings
        '''Dihitung, dibuat, dan disusun
        oleh Nuha\r\n\r\n $time''';

    //Added 30 as a margin for the layout
    page.graphics.drawString(
        footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds:
            Rect.fromLTWH(pageSize.width - 100, pageSize.height - 150, 0, 0));
  }

  Future<Uint8List> readImageData(String name) async {
    final data = await rootBundle.load('assets/images/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamData() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection("users")
        .doc(uid)
        .collection("anggaran")
        .where("kategori", isGreaterThanOrEqualTo: "Dana")
        .where("kategori", isLessThan: "Danb")
        .snapshots();
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
}
