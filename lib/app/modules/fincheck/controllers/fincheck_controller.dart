import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/fincheck/views/fincheck_result_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:nuha/mobile.dart';
import 'package:screenshot/screenshot.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class FincheckController extends GetxController {
  ScreenshotController screenshotController = ScreenshotController();

  //fincheck page 1, data pemasukan per bulan
  TextEditingController pendapatanAktif = TextEditingController();
  TextEditingController pendapatanPasif = TextEditingController();
  TextEditingController bisnisUsaha = TextEditingController();
  TextEditingController hasilInvestasi = TextEditingController();
  TextEditingController lainnya = TextEditingController();

  //fincheck page 2, data menabung per bulan
  TextEditingController nabungInvestasi = TextEditingController();
  TextEditingController totalTabungan = TextEditingController();

  //fincheck page 3, data investasi per bulan
  TextEditingController reksadana = TextEditingController();
  TextEditingController saham = TextEditingController();
  TextEditingController obligasi = TextEditingController();
  TextEditingController unitLink = TextEditingController();
  TextEditingController deposito = TextEditingController();
  TextEditingController crowdFunding = TextEditingController();
  TextEditingController ebaRitel = TextEditingController();
  TextEditingController logamMulia = TextEditingController();

  //fincheck page 4, data pengeluaran per bulan
  TextEditingController belanja = TextEditingController();
  TextEditingController transportasi = TextEditingController();
  TextEditingController sedekah = TextEditingController();
  TextEditingController pendidikan = TextEditingController();
  TextEditingController pajak = TextEditingController();
  TextEditingController premiAsuransi = TextEditingController();
  TextEditingController lainnyaP = TextEditingController();

  //fincheck page 5, data hutang dan aset per bulan
  TextEditingController aset = TextEditingController();
  TextEditingController hutang = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isVisible = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  String resultStatus = "";
  String toDo = "";
  String description = "";
  String title = "";
  int idealNum = 0;
  int selisih = 0;
  int nominal = 0;
  double idealPoint = 0;
  double point = 0;

  int totalPenghasilan = 0;
  int totalPengeluaran = 0;
  int totalInvestasi = 0;
  double gaugePoint = 0.0;
  int countG = 0;
  int countB = 0;
  var simpulan = "";

  void toggleDescriptionVisibility() {
    isVisible.toggle();
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

  void result() async {
    pengeluaranBulanan();
    penghasilanBulanan();
    totInvestasi();
    await deleteData();
    await countGoodData();
    await countBadData();

    await Future.wait([
      cashflow(),
      tabungan(),
      pendapatPasif(),
      danaDarurat(),
      investasi(),
      kekayaanBersih(),
      asetLikuid(),
      sedekahOk(),
    ]);

    countG = await countGoodData();
    countB = await countBadData();
    gaugePoint = countG.toDouble() / 8 * 100;

    if (gaugePoint <= 33) {
      simpulan =
          "Kesehatan keuanganmu buruk, terdapat $countB hal yang perlu kamu perbaiki dan $countG hal yang perlu kamu pertahankan!";
    } else if (gaugePoint <= 66) {
      simpulan =
          "Kesehatan keuanganmu cukup baik, terdapat $countB hal yang perlu kamu perbaiki dan $countG hal yang perlu kamu pertahankan!";
    } else {
      simpulan =
          "Kesehatan keuanganmu sangat baik, terdapat $countB hal yang perlu kamu perbaiki dan $countG hal yang perlu kamu pertahankan!";
    }

    Get.to(() => FincheckResultView());
  }

  void penghasilanBulanan() async {
    totalPenghasilan = int.parse(pendapatanAktif.text.replaceAll('.', '')) +
        int.parse(pendapatanPasif.text.replaceAll('.', '')) +
        int.parse(bisnisUsaha.text.replaceAll('.', '')) +
        int.parse(hasilInvestasi.text.replaceAll('.', '')) +
        int.parse(lainnya.text.replaceAll('.', ''));
  }

  void pengeluaranBulanan() async {
    totalPengeluaran = int.parse(belanja.text.replaceAll('.', '')) +
        int.parse(transportasi.text.replaceAll('.', '')) +
        int.parse(sedekah.text.replaceAll('.', '')) +
        int.parse(pendidikan.text.replaceAll('.', '')) +
        int.parse(pajak.text.replaceAll('.', '')) +
        int.parse(premiAsuransi.text.replaceAll('.', '')) +
        int.parse(lainnyaP.text.replaceAll('.', ''));
  }

  void totInvestasi() async {
    totalInvestasi = int.parse(reksadana.text.replaceAll('.', '')) +
        int.parse(saham.text.replaceAll('.', '')) +
        int.parse(obligasi.text.replaceAll('.', '')) +
        int.parse(unitLink.text.replaceAll('.', '')) +
        int.parse(deposito.text.replaceAll('.', '')) +
        int.parse(crowdFunding.text.replaceAll('.', '')) +
        int.parse(ebaRitel.text.replaceAll('.', '')) +
        int.parse(logamMulia.text.replaceAll('.', ''));
  }

  Future<void> cashflow() async {
    nominal = totalPengeluaran;

    if (totalPenghasilan >= totalPengeluaran) {
      resultStatus = "Good";
      toDo = "Lanjutkan kebiasaan baikmu!";
      description =
          "Total pemasukanmu lebih besar atau sama dengan total pengeluaranmu.";
    } else {
      resultStatus = "Bad";
      toDo = "Kurangi total pengengeluaranmu atau tingkatkan pemasukanmu.";
      description =
          "Total pengeluaranmu lebih besar daripada total pendapatanmu.";
    }

    title = "Alur Kas";

    idealNum = totalPenghasilan;

    idealPoint = 50;

    point = (idealNum.toDouble() / nominal.toDouble() * 100);

    if (point > 100) {
      point = 100;
    }

    await addData({
      "title": title,
      "description": description,
      "nominal": nominal,
      "resultStatus": resultStatus,
      "toDo": toDo,
      "selisih": selisih,
      "idealPoint": idealPoint,
      "point": point,
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
    });
  }

  Future<void> tabungan() async {
    nominal = int.parse(nabungInvestasi.text.replaceAll(".", ""));
    idealNum = (totalPenghasilan * 0.2).round();

    title = "Tabungan";

    if (nominal >= idealNum) {
      resultStatus = "Good";
      toDo = "Lanjutkan kebiasaan baikmu!";
      description =
          "Jumlah dana yang kamu tabung perbulannya sudah mematuhi minimal 20% dari pemasukan.";
    } else {
      resultStatus = "Bad";
      toDo = "Tambahkan tabunganmu sebesar";
      selisih = idealNum - nominal;
      description =
          "Minimal dana yang kamu tabung perbulannya minimal 20% dari pemasukan.";
    }

    idealPoint = 20;
    point = (nominal / totalPenghasilan * 100);

    await addData({
      "title": title,
      "description": description,
      "nominal": nominal,
      "resultStatus": resultStatus,
      "toDo": toDo,
      "selisih": selisih,
      "idealPoint": idealPoint,
      "point": point,
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
    });
  }

  Future<void> pendapatPasif() async {
    nominal = int.parse(pendapatanPasif.text.replaceAll(".", ""));
    idealNum = (totalPenghasilan * 0.5).round();

    title = "Pendapatan Pasif";

    if (nominal >= idealNum) {
      resultStatus = "Good";
      toDo = "Lanjutkan kebiasaan baikmu!";
      description =
          "Jumlah pendapatan pasifmu sudah 50% dari total pemasukanmu.";
    } else {
      resultStatus = "Bad";
      toDo = "Tingkatkan pendapatan pasifmu sebesar ";
      selisih = idealNum - nominal;
      description =
          "Minimal pendapatan pasifmu harus 50% dari total seluruh pemasukanmu.";
    }

    idealPoint = 50;
    point = (nominal / totalPenghasilan * 100);

    await addData({
      "title": title,
      "description": description,
      "nominal": nominal,
      "resultStatus": resultStatus,
      "toDo": toDo,
      "selisih": selisih,
      "idealPoint": idealPoint,
      "point": point,
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
    });
  }

  Future<void> danaDarurat() async {
    nominal =
        totalInvestasi + int.parse(totalTabungan.text.replaceAll(".", ""));

    idealNum = totalPengeluaran * 6;

    title = "Dana Darurat";

    if (nominal >= idealNum) {
      resultStatus = "Good";
      toDo = "Lanjutkan kebiasaan baikmu!";
      description =
          "Jumlah dana darurat sudah memenuhi minimal 6 kali jumlah pengeluaranmu.";
    } else {
      resultStatus = "Bad";
      toDo = "Tingkatkan tabungan atau investasimu sebesar ";
      selisih = idealNum - nominal;
      description =
          "Minimal dana darurat yang perlu kamu siapkan, yaitu 6 kali jumlah pengeluaranmu.";
    }

    point = (nominal.toDouble() / idealNum.toDouble() * 100);
    idealPoint = 100;

    await addData({
      "title": title,
      "description": description,
      "nominal": nominal,
      "resultStatus": resultStatus,
      "toDo": toDo,
      "selisih": selisih,
      "idealPoint": idealPoint,
      "point": point,
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
    });
  }

  Future<void> investasi() async {
    nominal = totalInvestasi;

    idealNum = (int.parse(aset.text.replaceAll(".", "")) * 0.5).round();

    title = "Investasi";

    if (nominal >= idealNum) {
      resultStatus = "Good";
      toDo = "Lanjutkan kebiasaan baikmu!";
      description =
          "Jumlah investasi sudah melebihi 50% aset yang kamu miliki.";
    } else {
      resultStatus = "Bad";
      toDo = "Tambah investasimu sebesar ";
      selisih = idealNum - nominal;
      description =
          "Minimal investasi yang perlu kamu miliki, yaitu 50% dari asetmu.";
    }

    idealPoint = 50;
    point = (nominal / idealNum * 100);

    await addData({
      "title": title,
      "description": description,
      "nominal": nominal,
      "resultStatus": resultStatus,
      "toDo": toDo,
      "selisih": selisih,
      "idealPoint": idealPoint,
      "point": point,
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
    });
  }

  Future<void> kekayaanBersih() async {
    int utang = int.parse(hutang.text.replaceAll(".", ""));
    int set = int.parse(aset.text.replaceAll(".", ""));
    nominal = int.parse(aset.text.replaceAll(".", "")) -
        int.parse(hutang.text.replaceAll(".", ""));

    idealNum = (int.parse(aset.text.replaceAll(".", "")) * 0.5).round();

    title = "Kekayaan Bersih";

    if (nominal >= idealNum) {
      resultStatus = "Good";
      toDo = "Lanjutkan kebiasaan baikmu!";
      description =
          "Aset yang kamu miliki sudah lebih besar atau sama dengan jumlah hutang.";
    } else {
      resultStatus = "Bad";
      toDo = "Tambah asetmu sebesar ";
      selisih = set - nominal;
      description = "Hutangmu lebih banyak dibandingkan aset yang kamu miliki.";
    }

    idealPoint = 50;
    point = (idealNum / utang * 100);

    await addData({
      "title": title,
      "description": description,
      "nominal": nominal,
      "resultStatus": resultStatus,
      "toDo": toDo,
      "selisih": selisih,
      "idealPoint": idealPoint,
      "point": point,
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
    });
  }

  Future<void> asetLikuid() async {
    idealNum =
        ((int.parse(totalTabungan.text.replaceAll(".", "")) + totalInvestasi) *
                0.15)
            .round();

    nominal = int.parse(totalTabungan.text.replaceAll(".", ""));

    if (idealNum >= nominal) {
      resultStatus = "Good";
      toDo = "Lanjutkan kebiasaan baikmu!";
      description = "Jumlah aset likuid kamu sudah baik, tidak melebihi 15%.";
    } else {
      resultStatus = "Bad";
      toDo = "Investasikan sebagian uang tabunganmu sebesar ";
      selisih = nominal - idealNum;
      description = "Jumlah aset likuid kamu melebihi 15%.";
    }

    title = "Aset Likuid";

    idealPoint = 15;
    point = (idealNum / nominal * 100);

    await addData({
      "title": title,
      "description": description,
      "nominal": nominal,
      "resultStatus": resultStatus,
      "toDo": toDo,
      "selisih": selisih,
      "idealPoint": idealPoint,
      "point": point,
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
    });
  }

  Future<void> sedekahOk() async {
    idealNum = (totalPenghasilan * 0.025).round();

    nominal = int.parse(sedekah.text.replaceAll(".", ""));

    if (nominal >= idealNum) {
      resultStatus = "Good";
      toDo = "Lanjutkan kebiasaan baikmu!";
      description = "Jumlah sedekahmu sudah melebihi 2.5% dari penghasilanmu.";
    } else {
      resultStatus = "Bad";
      toDo = "Tambahkan jumlah sedekahmu sebanyak ";
      selisih = idealNum - nominal;
      description = "Jumlah sedekahmu kurang dari 2.5% dari penghasilanmu";
    }

    title = "Sedekah";

    idealPoint = 2.5;
    point = (nominal / totalPenghasilan * 100);

    await addData({
      "title": title,
      "description": description,
      "nominal": nominal,
      "resultStatus": resultStatus,
      "toDo": toDo,
      "selisih": selisih,
      "idealPoint": idealPoint,
      "point": point,
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
    });
  }

  Future<void> deleteData() async {
    String uid = auth.currentUser!.uid;
    var collectionRef =
        firestore.collection("users").doc(uid).collection("fincheck");
    var querySnapshot = await collectionRef.get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> addData(Map<String, dynamic> data) async {
    isLoading.value = true;

    String uid = auth.currentUser!.uid;
    try {
      String id = firestore.collection("users").doc().id;
      await firestore
          .collection("users")
          .doc(uid)
          .collection("fincheck")
          .doc(id)
          .set(data);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamData() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection("users")
        .doc(uid)
        .collection("fincheck")
        .snapshots();
  }

  Stream<List<Data>> getDataStream() async* {
    String uid = auth.currentUser!.uid;
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshotStream = firestore
        .collection("users")
        .doc(uid)
        .collection("fincheck")
        .snapshots();

    await for (QuerySnapshot<Map<String, dynamic>> snapshot in snapshotStream) {
      List<Data> dataList = [];
      for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot
          in snapshot.docs) {
        Map<String, dynamic> data = docSnapshot.data();
        dataList.add(Data.fromMap(data));
      }

      yield dataList;
    }
  }

  Future<int> countGoodData() async {
    String uid = auth.currentUser!.uid;
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("fincheck")
        .where('resultStatus', isEqualTo: 'Good')
        .get();

    return snapshot.size;
  }

  Future<int> countBadData() async {
    String uid = auth.currentUser!.uid;
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("fincheck")
        .where('resultStatus', isEqualTo: 'Bad')
        .get();

    return snapshot.size;
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

    final time = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    PdfDocument document = PdfDocument();

    final page = document.pages.add();

    document.pageSettings.size = PdfPageSize.a4;

    const pageSize = PdfPageSize.a4;

    page.graphics.drawImage(PdfBitmap(await readImageData('NUHA.png')),
        const Rect.fromLTWH(0, 0, 200, 50));

    PdfTextElement textElement = PdfTextElement(
        text: "Hasil Cek Kesehatan Keuangan",
        font: PdfStandardFont(PdfFontFamily.helvetica, 18,
            style: PdfFontStyle.bold));

    PdfLayoutResult layoutResult = textElement.draw(
        page: page,
        bounds: Rect.fromLTWH(0, 60, pageSize.width, pageSize.height))!;

    page.graphics.drawImage(PdfBitmap(capturedImage),
        Rect.fromLTWH(50, 80, pageSize.width - 180, pageSize.height - 470));

    textElement.text = simpulan;
    textElement.font = PdfStandardFont(PdfFontFamily.helvetica, 14,
        style: PdfFontStyle.regular);
    layoutResult = textElement.draw(
        page: page,
        bounds: Rect.fromLTWH(60, layoutResult.bounds.bottom + 210,
            pageSize.width - 180, pageSize.height))!;

    textElement.text = "Beberapa hal perlu diperbaiki:";
    textElement.font =
        PdfStandardFont(PdfFontFamily.helvetica, 14, style: PdfFontStyle.bold);
    layoutResult = textElement.draw(
        page: page,
        bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + 10,
            pageSize.width - 200, pageSize.height))!;

    List<Data> dataList = await getDataStream().first;

    for (int i = 0; i < dataList.length; i++) {
      Data data = dataList[i];
      if (data.resultStatus == "Bad") {
        textElement.text = data.title!;
        textElement.font = PdfStandardFont(PdfFontFamily.helvetica, 14,
            style: PdfFontStyle.bold);
        textElement.brush = PdfSolidBrush(PdfColor(255, 203, 36));
        layoutResult = textElement.draw(
            page: page,
            bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + 5,
                pageSize.width - 350, pageSize.height))!;

        //description
        textElement.text =
            "${data.toDo!} ${NumberFormat.currency(locale: 'id', symbol: "Rp", decimalDigits: 0).format(data.nominal!)}";
        textElement.font = PdfStandardFont(PdfFontFamily.helvetica, 14,
            style: PdfFontStyle.regular);
        textElement.brush = PdfSolidBrush(PdfColor(31, 31, 31));
        layoutResult = textElement.draw(
            page: page,
            bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + 2,
                pageSize.width - 350, pageSize.height))!;
      }
    }

    textElement.text = "Beberapa hal perlu dipertahankan:";
    textElement.font =
        PdfStandardFont(PdfFontFamily.helvetica, 14, style: PdfFontStyle.bold);
    layoutResult = textElement.draw(
        page: page,
        bounds:
            Rect.fromLTWH(280, 335, pageSize.width - 350, pageSize.height))!;

    for (int i = 0; i < dataList.length; i++) {
      Data data = dataList[i];
      if (data.resultStatus == "Good") {
        //title
        textElement.text = data.title!;
        textElement.font = PdfStandardFont(PdfFontFamily.helvetica, 14,
            style: PdfFontStyle.bold);
        textElement.brush = PdfSolidBrush(PdfColor(83, 153, 139));
        layoutResult = textElement.draw(
            page: page,
            bounds: Rect.fromLTWH(280, layoutResult.bounds.bottom + 5,
                pageSize.width - 350, pageSize.height))!;

        //description
        textElement.text = data.description!;
        textElement.font = PdfStandardFont(PdfFontFamily.helvetica, 14,
            style: PdfFontStyle.regular);
        textElement.brush = PdfSolidBrush(PdfColor(31, 31, 31));
        layoutResult = textElement.draw(
            page: page,
            bounds: Rect.fromLTWH(280, layoutResult.bounds.bottom + 2,
                pageSize.width - 350, pageSize.height))!;
      }
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

class Data {
  String? title;
  String? description;
  String? resultStatus;
  String? toDo;
  int? nominal;
  int? selisih;

  Data({
    this.title,
    this.description,
    this.resultStatus,
    this.toDo,
    this.nominal,
    this.selisih,
  });

  factory Data.fromMap(Map data) {
    return Data(
      title: data['title'],
      description: data['description'],
      resultStatus: data['resultStatus'],
      toDo: data['toDo'],
      nominal: data['nominal'],
      selisih: data['selisih'],
    );
  }
}
