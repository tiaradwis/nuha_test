import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/fincheck/controllers/fincheck_controller.dart';
import 'package:nuha/app/modules/fincheck/views/fincheck_lima_view.dart';
import 'package:nuha/app/widgets/field_currency.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';

class FincheckEmpatView extends GetView<FincheckController> {
  const FincheckEmpatView({Key? key}) : super(key: key);

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
        padding: EdgeInsets.fromLTRB(7.778.w, 0.625.w, 7.778.w, 0),
        children: [
          Text(
            "Langkah 4",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: grey400,
                ),
          ),
          SizedBox(
            height: 0.5.h,
          ),
          GradientText(
            "Berapa pengeluaranmu dalam sebulan?",
            style: Theme.of(context).textTheme.displaySmall,
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
            labelText: "Belanja Kebutuhan",
            contr: controller.belanja,
            infoText:
                "Dana yang kamu keluarkan untuk memenuhi kebutuhan selama satu bulan.",
          ),
          FieldCurrency(
            labelText: "Transportasi",
            contr: controller.transportasi,
            infoText:
                "Dana untuk membeli bahan bakar kendaraan, perbaikan kendaraan, atau transportasi umum.",
          ),
          FieldCurrency(
            labelText: "Sedekah/Donasi",
            contr: controller.sedekah,
            infoText: "Dana yang kamu sisihkan untuk sesama.",
          ),
          FieldCurrency(
            labelText: "Pendidikan",
            contr: controller.pendidikan,
            infoText: "Dana kebutuhan pendidikan, seperti sekolah dan kursus.",
          ),
          FieldCurrency(
            labelText: "Pajak",
            contr: controller.pajak,
            infoText: "Iuran yang diwajibkan oleh negara.",
          ),
          FieldCurrency(
            labelText: "Premi Asuransi Bulanan",
            contr: controller.premiAsuransi,
            infoText:
                "Dana untuk asuransi kesehatan, kendaraan, pendidikan, dan lainnya.",
          ),
          FieldCurrency(
            labelText: "Lainnya",
            contr: controller.lainnyaP,
            infoText: "Jumlah dana pengeluaran lainnya.",
          ),
          SizedBox(
            height: 5.25.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                      side: const BorderSide(width: 1, color: buttonColor2),
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
                    if (controller.belanja.value.text.isNotEmpty &&
                        controller.transportasi.value.text.isNotEmpty &&
                        controller.sedekah.value.text.isNotEmpty &&
                        controller.pendidikan.value.text.isNotEmpty &&
                        controller.pajak.value.text.isNotEmpty &&
                        controller.premiAsuransi.value.text.isNotEmpty &&
                        controller.lainnya.value.text.isNotEmpty) {
                      Get.to(() => const FincheckLimaView());
                    } else {
                      controller.errMsg("Mohon isi seluruh kolom yang ada!");
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      )),
    );
  }
}
