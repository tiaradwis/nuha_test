import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/controllers/pk_pensiun_controller.dart';
import 'package:nuha/app/widgets/field_currency.dart';
import 'package:nuha/app/widgets/field_number.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';
import '../controllers/perencanaan_keuangan_controller.dart';

class PkPensiunView extends GetView<PkPensiunController> {
  PkPensiunView({Key? key}) : super(key: key);
  final c = Get.find<PkPensiunController>();
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
              width: 100.w,
              height: 79.625.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 0.5.h,
                  ),
                  GradientText(
                    "Dana Pensiun",
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
                    "Perencanaan dana pensiun bertujuan untuk memastikan kesejahteraan keuangan di masa pensiun.",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: grey400,
                        ),
                  ),
                  SizedBox(
                    height: 3.125.h,
                  ),
                  FieldNumber(
                      labelText: "Berapa Umur Kamu Saat Ini?",
                      contr: c.umurSaatIni,
                      hintText: "20 tahun"),
                  FieldNumber(
                      labelText: "Berapa Usia Pensiun Yang Kamu Harapkan?",
                      contr: c.umurPensiun,
                      hintText: "60 tahun"),
                  FieldCurrency(
                      labelText: "Biaya Hidup",
                      contr: c.biayaHidup,
                      infoText:
                          "Biaya hidup adalah total dana saat ini yang digunakan setiap bulan untuk keperluan sehari-hari."),
                  FieldCurrency(
                      labelText: "Dana Yang Terkumpul",
                      contr: c.nomDanaTersedia,
                      infoText:
                          "Dana yang terkumpul adalah uang yang telah disimpan untuk waktu pensiunmu."),
                  FieldCurrency(
                      labelText: "Dana Yang Dapat Disisihkan",
                      contr: c.nomDanaDisisihkan,
                      infoText:
                          "Dana yang dapat disisihkan adalah uang yang dapat kamu sisihkan setiap bulannya untuk tabungan dana pensiun."),
                ],
              ),
            ),
            SizedBox(
              width: 100.w,
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
                        if (c.umurSaatIni.value.text.isNotEmpty &&
                            c.umurPensiun.value.text.isNotEmpty &&
                            c.nomDanaTersedia.value.text.isNotEmpty &&
                            c.nomDanaDisisihkan.value.text.isNotEmpty &&
                            c.biayaHidup.value.text.isNotEmpty) {
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
          ],
        ),
      ),
    );
  }
}
