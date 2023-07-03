import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/cashflow/models/laporankeuangan_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:nuha/mobile.dart';
import 'package:screenshot/screenshot.dart';
import 'package:intl/intl.dart';

class LaporankeuanganController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  RxList<LineChart> lineChartM = <LineChart>[].obs;
  RxList<LineChart> lineChartK = <LineChart>[].obs;
  RxList<ChartPemasukan> chartPemasukan = <ChartPemasukan>[].obs;
  RxList<ChartPengeluaran> chartPengeluaran = <ChartPengeluaran>[].obs;

  var startDate = DateTime(
          DateTime.now().year, DateTime.now().month - 1, DateTime.now().day)
      .obs;
  var endDate = DateTime.now().obs;
  var totalPendapatan = 0.obs;
  var totalPengeluaran = 0.obs;

  RxBool shouldRefreshPage = false.obs;

  ScreenshotController screenshot1Controller = ScreenshotController();
  ScreenshotController screenshot2Controller = ScreenshotController();

  @override
  void onInit() {
    super.onInit();

    getDataMasukKeluar();
    getDataPemasukan();
    getDataPengeluaran();
  }

  Future pickDateRange() async {
    shouldRefreshPage.value = true;
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: Get.context!,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDateRange:
          DateTimeRange(start: startDate.value, end: endDate.value),
      firstDate: DateTime(2000),
      lastDate: DateTime(2024),
      cancelText: "BATAL",
      confirmText: "OK",
      saveText: "SIMPAN",
      helpText: "Pilih Rentang Tanggal",
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
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      )),
            ),
          ),
          child: SizedBox(
            height: 40.h,
            width: 20.w, // Sesuaikan dengan ukuran yang diinginkan
            child: child,
          ),
        );
      },
    );

    if (newDateRange == null) {
      return;
    } else {
      startDate.value = newDateRange.start;
      endDate.value = newDateRange.end;
    }

    // getDataAnggaran();
    getDataPengeluaran();
    getDataMasukKeluar();
    getDataPemasukan();
    shouldRefreshPage.value = false;
  }

  Future<void> getDataPemasukan() async {
    String uid = auth.currentUser!.uid;
    var snapshotsPendapatan = await firestore
        .collection("users")
        .doc(uid)
        .collection("transaksi")
        .where("jenisTransaksi", isEqualTo: "Pendapatan")
        .where("tanggalTransaksi",
            isGreaterThanOrEqualTo: startDate.value,
            isLessThanOrEqualTo: endDate.value)
        .get();
    Map<String, int> kategoriTotal = {};

    snapshotsPendapatan.docs.forEach((doc) {
      String kategori = doc.data()['kategori'];
      int nominal = doc.data()['nominal'];

      if (kategoriTotal.containsKey(kategori)) {
        kategoriTotal[kategori] = kategoriTotal[kategori]! + nominal;
      } else {
        kategoriTotal[kategori] = nominal;
      }
    });

    List<ChartPemasukan> list = kategoriTotal.entries
        .map((e) => ChartPemasukan(
              kategori: e.key,
              nominal: e.value,
            ))
        .toList();

    list.sort((a, b) => b.nominal!.compareTo(a.nominal!.toInt()));

    chartPemasukan.clear();
    chartPemasukan.assignAll(list);
    // print(chartPemasukan);
  }

  Future<void> getDataPengeluaran() async {
    String uid = auth.currentUser!.uid;
    var snapshotsPengeluaran = await firestore
        .collection("users")
        .doc(uid)
        .collection("transaksi")
        .where("jenisTransaksi", isEqualTo: "Pengeluaran")
        .where("tanggalTransaksi",
            isGreaterThanOrEqualTo: startDate.value,
            isLessThanOrEqualTo: endDate.value)
        .get();
    Map<String, int> kategoriTotal = {};

    snapshotsPengeluaran.docs.forEach((doc) {
      String kategori = doc.data()['kategori'];
      int nominal = doc.data()['nominal'];

      if (kategoriTotal.containsKey(kategori)) {
        kategoriTotal[kategori] = kategoriTotal[kategori]! + nominal;
      } else {
        kategoriTotal[kategori] = nominal;
      }
    });

    List<ChartPengeluaran> list = kategoriTotal.entries
        .map((e) => ChartPengeluaran(
              kategori: e.key,
              nominal: e.value,
            ))
        .toList();

    list.sort((a, b) => b.nominal!.compareTo(a.nominal!.toInt()));

    chartPengeluaran.clear();
    chartPengeluaran.assignAll(list);
    // print(chartPemasukan);
  }

  Future<void> getDataMasukKeluar() async {
    String uid = auth.currentUser!.uid;
    var snapShotsPemasukan = await firestore
        .collection("users")
        .doc(uid)
        .collection("transaksi")
        .where("jenisTransaksi", isEqualTo: "Pendapatan")
        .where("tanggalTransaksi",
            isGreaterThanOrEqualTo: startDate.value,
            isLessThanOrEqualTo: endDate.value)
        .orderBy("tanggalTransaksi")
        .get();

    int totalNominal = snapShotsPemasukan.docs.fold(0, (total, doc) {
      int nominal = doc.data()["nominal"] as int;
      return total + nominal;
    });

    totalPendapatan.value = totalNominal;

    List<LineChart> list = snapShotsPemasukan.docs
        .map((e) => LineChart(
              jenisTransaksi: e.data()['jenisTransaksi'],
              nominal: e.data()['nominal'],
              // tanggalTransaksi: e.data()['tanggalTransaksi'].toDate(),
              tanggalTransaksi: e.data()['tanggalTransaksi'].toDate(),
              color: const Color(0XFF0096C7),
            ))
        .toList();
    lineChartM.assignAll(list);

    var snapShotsPengeluaran = await firestore
        .collection("users")
        .doc(uid)
        .collection("transaksi")
        .where("jenisTransaksi", isEqualTo: "Pengeluaran")
        .where("tanggalTransaksi",
            isGreaterThanOrEqualTo: startDate.value,
            isLessThanOrEqualTo: endDate.value)
        .orderBy("tanggalTransaksi")
        .get();

    int totalNominal2 = snapShotsPengeluaran.docs.fold(0, (total, doc) {
      int nominal = doc.data()["nominal"] as int;
      return total + nominal;
    });

    totalPengeluaran.value = totalNominal2;

    List<LineChart> list2 = snapShotsPengeluaran.docs
        .map((e) => LineChart(
            jenisTransaksi: e.data()['jenisTransaksi'],
            nominal: e.data()['nominal'],
            // tanggalTransaksi: e.data()['tanggalTransaksi'].toDate(),
            tanggalTransaksi: e.data()['tanggalTransaksi'].toDate(),
            color: const Color(0XFFCC444B)))
        .toList();
    lineChartK.assignAll(list2);
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

  Future<void> getPdf(List<Uint8List> capturedImage, String name) async {
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

    final time = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    PdfDocument document = PdfDocument();

    final page = document.pages.add();

    document.pageSettings.size = PdfPageSize.a4;

    const pageSize = PdfPageSize.a4;

    page.graphics.drawImage(PdfBitmap(await readImageData('NUHA.png')),
        const Rect.fromLTWH(0, 0, 200, 50));

    PdfTextElement textElement = PdfTextElement(
        text: "Laporan Keuangan",
        font: PdfStandardFont(PdfFontFamily.helvetica, 18,
            style: PdfFontStyle.bold));

    PdfLayoutResult layoutResult = textElement.draw(
        page: page,
        bounds: Rect.fromLTWH(0, 60, pageSize.width, pageSize.height))!;

    textElement.text =
        "${DateFormat('dd MMMM yyyy', 'id').format(startDate.value)} - ${DateFormat('dd MMMM yyyy', 'id').format(endDate.value)}";
    textElement.font =
        PdfStandardFont(PdfFontFamily.helvetica, 16, style: PdfFontStyle.bold);
    layoutResult = textElement.draw(
        page: page,
        bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + 10,
            pageSize.width, pageSize.height))!;

    page.graphics.drawImage(PdfBitmap(capturedImage[0]),
        Rect.fromLTWH(0, 0, pageSize.width - 370, pageSize.height - 400));

    page.graphics.drawImage(PdfBitmap(capturedImage[1]),
        Rect.fromLTWH(250, 0, pageSize.width - 370, pageSize.height - 400));

    textElement.text = "Pengeluaranmu:";
    textElement.font =
        PdfStandardFont(PdfFontFamily.helvetica, 14, style: PdfFontStyle.bold);
    textElement.brush = PdfSolidBrush(PdfColor(31, 31, 31));
    layoutResult = textElement.draw(
        page: page,
        bounds: Rect.fromLTWH(0, 335, pageSize.width - 200, pageSize.height))!;

    for (int i = 0; i < chartPengeluaran.length; i++) {
      ChartPengeluaran data = chartPengeluaran[i];

      textElement.text = data.kategori!;
      textElement.font = PdfStandardFont(PdfFontFamily.helvetica, 14,
          style: PdfFontStyle.regular);
      textElement.brush = PdfSolidBrush(PdfColor(31, 31, 31));
      layoutResult = textElement.draw(
          page: page,
          bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + 5,
              pageSize.width - 350, pageSize.height))!;

      // //description
      textElement.text =
          NumberFormat.currency(locale: 'id', symbol: "Rp", decimalDigits: 0)
              .format(data.nominal!);
      textElement.font = PdfStandardFont(PdfFontFamily.helvetica, 14,
          style: PdfFontStyle.regular);
      textElement.brush = PdfSolidBrush(PdfColor(228, 30, 30));
      layoutResult = textElement.draw(
          page: page,
          bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + 2,
              pageSize.width - 350, pageSize.height))!;
    }

    textElement.text = "Pendapatanmu:";
    textElement.font =
        PdfStandardFont(PdfFontFamily.helvetica, 14, style: PdfFontStyle.bold);
    textElement.brush = PdfSolidBrush(PdfColor(31, 31, 31));
    layoutResult = textElement.draw(
        page: page,
        bounds:
            Rect.fromLTWH(280, 335, pageSize.width - 350, pageSize.height))!;

    for (int i = 0; i < chartPemasukan.length; i++) {
      ChartPemasukan data = chartPemasukan[i];

      textElement.text = data.kategori!;
      textElement.font = PdfStandardFont(PdfFontFamily.helvetica, 14,
          style: PdfFontStyle.regular);
      textElement.brush = PdfSolidBrush(PdfColor(31, 31, 31));
      layoutResult = textElement.draw(
          page: page,
          bounds: Rect.fromLTWH(280, layoutResult.bounds.bottom + 5,
              pageSize.width - 350, pageSize.height))!;

      textElement.text =
          NumberFormat.currency(locale: 'id', symbol: "Rp", decimalDigits: 0)
              .format(data.nominal!);
      textElement.font = PdfStandardFont(PdfFontFamily.helvetica, 14,
          style: PdfFontStyle.regular);
      textElement.brush = PdfSolidBrush(PdfColor(0, 150, 199));
      layoutResult = textElement.draw(
          page: page,
          bounds: Rect.fromLTWH(280, layoutResult.bounds.bottom + 2,
              pageSize.width - 350, pageSize.height))!;
    }

    List<int> bytes = await document.save();

    await Future.delayed(const Duration(seconds: 5));

    Get.back();

    saveAndLaunchFile(bytes, '${name}_$time.pdf');

    document.dispose();
  }

  Future<Uint8List> readImageData(String name) async {
    final data = await rootBundle.load('assets/images/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
}
