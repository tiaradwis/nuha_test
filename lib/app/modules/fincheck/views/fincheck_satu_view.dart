import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/fincheck/controllers/fincheck_controller.dart';
import 'package:nuha/app/modules/fincheck/views/fincheck_dua_view.dart';
import 'package:nuha/app/widgets/field_currency.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';

class FincheckSatuView extends GetView<FincheckController> {
  const FincheckSatuView({Key? key}) : super(key: key);

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
                Text(
                  "Langkah 1",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: grey400,
                      ),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                GradientText(
                  "Berapa penghasilan kamu setiap bulannya?",
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
                  "(Jika tidak ada, ketika 0)",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: grey400,
                      ),
                ),
                SizedBox(
                  height: 3.125.h,
                ),
                FieldCurrency(
                  labelText: "Pendapatan Aktif",
                  contr: controller.pendapatanAktif,
                  infoText:
                      "Penghasilan yang kamu peroleh setelah bekerja setiap bulan.",
                ),
                FieldCurrency(
                  labelText: "Pendapatan Pasif",
                  contr: controller.pendapatanPasif,
                  infoText:
                      "Penghasilan yang kamu dapatkan setiap bulan tanpa terlibat aktif dalam sebuah kegiatan bisnis.",
                ),
                FieldCurrency(
                  labelText: "Bisnis Usaha",
                  contr: controller.bisnisUsaha,
                  infoText:
                      "Penghasilan yang kamu dapatkan dari hasil penjualan barang atau jasa.",
                ),
                FieldCurrency(
                  labelText: "Hasil Investasi",
                  contr: controller.hasilInvestasi,
                  infoText:
                      "Penghasilan yang kamu dapatkan dari pembayaran dividen atau bunga ketika kamu menanamkan modal atau menjual aset.",
                ),
                FieldCurrency(
                  labelText: "Lainnya",
                  contr: controller.lainnya,
                  infoText: "Penghasilan tambahan, seperti bonus.",
                ),
              ],
            ),
          ),
          SizedBox(
            // margin: EdgeInsets.only(
            //   top: 1.625.h,
            // ),
            width: 100.w,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 4.4444.w,
                      height: 0.5.h,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: buttonColor1),
                    ),
                    SizedBox(
                      width: 1.38889.w,
                    ),
                    Container(
                      width: 4.4444.w,
                      height: 0.5.h,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: grey50),
                    ),
                    SizedBox(
                      width: 1.38889.w,
                    ),
                    Container(
                      width: 4.4444.w,
                      height: 0.5.h,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: grey50),
                    ),
                    SizedBox(
                      width: 1.38889.w,
                    ),
                    Container(
                      width: 4.4444.w,
                      height: 0.5.h,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: grey50),
                    ),
                    SizedBox(
                      width: 1.38889.w,
                    ),
                    Container(
                      width: 4.4444.w,
                      height: 0.5.h,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: grey50),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.625.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 39.7222.w,
                      height: 5.5.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            side:
                                const BorderSide(width: 1, color: buttonColor2),
                            backgroundColor: backgroundColor1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: Text(
                          "Kembali",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: buttonColor2),
                        ),
                        onPressed: () => Get.back(),
                      ),
                    ),
                    SizedBox(
                      width: 39.7222.w,
                      height: 5.5.h,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Text(
                            "Selanjutnya",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.white),
                          ),
                          onPressed: () {
                            if (controller.pendapatanAktif.value.text.isNotEmpty &&
                                controller
                                    .pendapatanPasif.value.text.isNotEmpty &&
                                controller.bisnisUsaha.value.text.isNotEmpty &&
                                controller
                                    .hasilInvestasi.value.text.isNotEmpty &&
                                controller.lainnya.value.text.isNotEmpty) {
                              Get.to(() => const FincheckDuaView());
                            } else {
                              controller
                                  .errMsg("Mohon isi seluruh kolom yang ada!");
                            }
                          }),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
