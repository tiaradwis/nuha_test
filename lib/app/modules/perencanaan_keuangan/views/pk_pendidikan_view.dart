import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/controllers/pk_pendidikan_controller.dart';
import 'package:nuha/app/widgets/field_currency.dart';
import 'package:nuha/app/widgets/field_number.dart';
import 'package:nuha/app/widgets/field_text.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';
import '../controllers/perencanaan_keuangan_controller.dart';

class PkPendidikanView extends GetView<PkPendidikanController> {
  PkPendidikanView({Key? key}) : super(key: key);

  final c = Get.find<PkPendidikanController>();

  final con = Get.find<PerencanaanKeuanganController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(5.875.h),
        child: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: titleColor,
              size: 18.sp,
            ),
            onPressed: () => Get.back(),
          ),
          backgroundColor: backgroundColor1,
          elevation: 0,
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 7.778.w,
          ),
          children: [
            Container(
              padding: EdgeInsets.only(top: 0.625.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 0.5.h,
                  ),
                  GradientText(
                    "Dana Pendidikan",
                    style: Theme.of(context).textTheme.displaySmall!,
                    colors: const [
                      buttonColor1,
                      buttonColor2,
                    ],
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Text(
                    "Dana pendidikan bertujuan untuk mempersiapkan dan mengalokasikan dana secara terencana guna membiayai masa depan pendidikan anak.",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: grey400,
                        ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  FieldText(
                      labelText: "Nama Anak",
                      contr: c.namaAnak,
                      hintText: "Masukkan nama anak"),
                  FieldNumber(
                      labelText: "Umur Anak",
                      contr: c.umurAnak,
                      hintText: "Umur anak (tahun)"),
                  FieldNumber(
                      labelText: "Umur Anak Masuk Sekolah",
                      contr: c.umurAnakMasuk,
                      hintText: "Umur anak saat masuk sekolah (tahun)"),
                  FieldNumber(
                      labelText: "Durasi Pendidikan",
                      contr: c.lamaPendidikan,
                      hintText: "Lama anak menempuh pendidikan (tahun)"),
                  FieldCurrency(
                      labelText: "Total Uang Pangkal",
                      contr: c.uangPangkal,
                      infoText:
                          "Uang pangkal adalah biaya pendidikan yang hanya dibayarkan sekali saat registrasi atau pendaftaran."),
                  FieldCurrency(
                      labelText: "Biaya SPP",
                      contr: c.uangSPP,
                      infoText:
                          "Uang SPP adalah biaya perbulan yang harus dikeluarkan untuk biaya sekolah."),
                  FieldCurrency(
                      labelText: "Dana Yang Sudah Ada",
                      contr: c.nomDanaTersedia,
                      infoText:
                          "Dana yang sudah ada adalah uang yang telah Anda simpan untuk biaya pendidikan anak."),
                  FieldCurrency(
                      labelText: "Dana Yang Dapat Disisihkan",
                      contr: c.nomDanaSisih,
                      infoText:
                          "Dana yang dapat anda sisihkan adalah uang yang dapat anda sisihkan setiap bulannya untuk biaya pendidikan anak.")
                ],
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            SizedBox(
              child: Center(
                child: SizedBox(
                  width: 84.1667.w,
                  height: 5.5.h,
                  child: Obx(
                    () => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: buttonColor2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Text(
                        c.isLoading.isFalse ? "Hitung Dana" : "Loading...",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                      onPressed: () {
                        if (c.namaAnak.value.text.isNotEmpty &&
                            c.umurAnak.value.text.isNotEmpty &&
                            c.umurAnakMasuk.value.text.isNotEmpty &&
                            c.uangPangkal.value.text.isNotEmpty &&
                            c.uangSPP.value.text.isNotEmpty &&
                            c.nomDanaSisih.value.text.isNotEmpty &&
                            c.lamaPendidikan.value.text.isNotEmpty &&
                            c.nomDanaTersedia.value.text.isNotEmpty) {
                          if (c.isLoading.isFalse) {
                            c.countDana(context);
                          }
                        } else {
                          con.errMsg("Mohon isi seluruh kolom yang ada!");
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
          ],
        ),
      ),
    );
  }
}
