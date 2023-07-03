import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/controllers/pk_pernikahan_controller.dart';
import 'package:nuha/app/widgets/field_currency.dart';
import 'package:nuha/app/widgets/field_number.dart';
import 'package:nuha/app/widgets/field_text.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';
import '../controllers/perencanaan_keuangan_controller.dart';

class PkPernikahanView extends GetView<PkPernikahanController> {
  PkPernikahanView({Key? key}) : super(key: key);
  final c = Get.find<PkPernikahanController>();
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
                    "Dana Pernikahan",
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
                    "Dana pernikahan bertujuan untuk mengatur keuangan dengan bijaksana dan memastikan pernikahan dapat terlaksana.",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: grey400,
                        ),
                  ),
                  SizedBox(
                    height: 3.125.h,
                  ),
                  FieldText(
                      labelText: "Nama Pasangan",
                      contr: c.namaPasangan,
                      hintText: "Masukkan nama pasangan"),
                  FieldCurrency(
                      labelText: "Total Biaya Yang Ingin Dicapai",
                      contr: c.nomBiaya,
                      infoText:
                          "Perkiraan total biaya untuk seluruh rangkaian acara pernikahan."),
                  FieldNumber(
                      labelText: "Kapan Kamu Ingin Mencapai Target?",
                      contr: c.bulanTercapai,
                      hintText: "24 (bulan)"),
                  FieldCurrency(
                      labelText: "Dana Yang Sudah Ada",
                      contr: c.nomDanaTersedia,
                      infoText:
                          "Dana yang sudah ada adalah uang yang telah kamu simpan untuk dana pernikahan."),
                  FieldCurrency(
                      labelText: "Dana Yang Dapat Disisihkan",
                      contr: c.nomDanaDisisihkan,
                      infoText:
                          "Dana yang dapat kamu sisihkan adalah uang yang dapat kamu sisihkan setiap bulannya untuk tabungan dana pernikahan.")
                ],
              ),
            ),
            SizedBox(
              width: 100.w,
              child: Center(
                child: SizedBox(
                  width: 84.1667.w,
                  height: 5.5.h,
                  child: Obx(() => ElevatedButton(
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
                          if (c.namaPasangan.value.text.isNotEmpty &&
                              c.nomBiaya.value.text.isNotEmpty &&
                              c.nomDanaTersedia.value.text.isNotEmpty &&
                              c.nomDanaDisisihkan.value.text.isNotEmpty &&
                              c.bulanTercapai.value.text.isNotEmpty) {
                            if (c.isLoading.isFalse) {
                              c.countDana(context);
                            }
                          } else {
                            con.errMsg("Mohon isi seluruh kolom yang ada!");
                          }
                        },
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
