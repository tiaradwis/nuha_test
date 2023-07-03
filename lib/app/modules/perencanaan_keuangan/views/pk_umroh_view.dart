import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/controllers/pk_umroh_controller.dart';
import 'package:nuha/app/widgets/field_currency.dart';
import 'package:nuha/app/widgets/field_number.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';
import '../controllers/perencanaan_keuangan_controller.dart';

class PkUmrohView extends GetView<PkUmrohController> {
  PkUmrohView({Key? key}) : super(key: key);

  final c = Get.find<PkUmrohController>();
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
                    "Dana Haji/Umroh",
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
                    "Dana haji/umroh bertujuan untuk menyiapkan dana yang cukup dan menghindari beban keuangan yang berlebih.",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: grey400,
                        ),
                  ),
                  SizedBox(
                    height: 3.125.h,
                  ),
                  FieldCurrency(
                      labelText: "Total Biaya Yang Ingin Dicapai",
                      contr: c.nomHajiUmroh,
                      infoText:
                          "Total biaya yang ingin dicapai adalah total dana yang dikeluarkan untuk paket keberangkatan haji/umroh ditambah biaya lainnya."),
                  FieldNumber(
                      labelText: "Kapan Kamu Ingin Mencapai Target?",
                      contr: c.bulanTercapai,
                      hintText: "24 (bulan)"),
                  FieldCurrency(
                      labelText: "Dana Yang Sudah Ada",
                      contr: c.nomDanaTersedia,
                      infoText:
                          "Dana yang sudah ada adalah uang yang telah Anda simpan untuk biaya keberangkatan."),
                  FieldCurrency(
                      labelText: "Dana Yang Dapat Disisihkan",
                      contr: c.nomDanaSisih,
                      infoText:
                          "Dana yang dapat anda sisihkan adalah uang yang dapat anda sisihkan setiap bulannya untuk biaya haji/umroh.")
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
                          if (c.nomHajiUmroh.value.text.isNotEmpty &&
                              c.bulanTercapai.value.text.isNotEmpty &&
                              c.nomDanaTersedia.value.text.isNotEmpty &&
                              c.nomDanaSisih.value.text.isNotEmpty) {
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
