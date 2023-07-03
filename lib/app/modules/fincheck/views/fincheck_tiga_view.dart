import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/fincheck/controllers/fincheck_controller.dart';
import 'package:nuha/app/modules/fincheck/views/fincheck_empat_view.dart';
import 'package:nuha/app/widgets/field_currency.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';

class FincheckTigaView extends GetView<FincheckController> {
  const FincheckTigaView({Key? key}) : super(key: key);
  // final appBarheight = AppBar().preferredSize.height;

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
            "Langkah 3",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: grey400,
                ),
          ),
          SizedBox(
            height: 0.5.h,
          ),
          GradientText(
            "Produk investasi apa yang sudah kamu punya?",
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
            labelText: "Reksadana",
            contr: controller.reksadana,
            infoText: "Investasi reksadana pasar uang.",
          ),
          FieldCurrency(
            labelText: "Saham",
            contr: controller.saham,
            infoText: "Investasi kepemilikan modal pada perusahaan.",
          ),
          FieldCurrency(
            labelText: "Obligasi/P2P Landing",
            contr: controller.obligasi,
            infoText: "Investasi surat hutang yang bisa diperjualbelikan.",
          ),
          FieldCurrency(
            labelText: "Unit Link",
            contr: controller.unitLink,
            infoText: "Investasi gabungan dari produk layanan asuransi.",
          ),
          FieldCurrency(
            labelText: "Deposito",
            contr: controller.deposito,
            infoText:
                "Simpanan di bank dengan jumlah suka bunga dan dalam jangka waktu tertentu.",
          ),
          FieldCurrency(
            labelText: "Crowd Funding",
            contr: controller.crowdFunding,
            infoText: "Investasi dalam suatu proyek.",
          ),
          FieldCurrency(
            labelText: "EBA Ritel",
            contr: controller.ebaRitel,
            infoText: "Investasi pada sektor ritel.",
          ),
          FieldCurrency(
            labelText: "Logam Mulia",
            contr: controller.logamMulia,
            infoText:
                "Investasi logam mulian, seperti emask, perak, dan platinum.",
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
                    if (controller.reksadana.value.text.isNotEmpty &&
                        controller.saham.value.text.isNotEmpty &&
                        controller.obligasi.value.text.isNotEmpty &&
                        controller.unitLink.value.text.isNotEmpty &&
                        controller.deposito.value.text.isNotEmpty &&
                        controller.crowdFunding.value.text.isNotEmpty &&
                        controller.ebaRitel.value.text.isNotEmpty &&
                        controller.logamMulia.value.text.isNotEmpty) {
                      Get.to(() => const FincheckEmpatView());
                    } else {
                      controller.errMsg("Mohon isi seluruh kolom yang ada!");
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 3.75.h,
          ),
        ],
      )),
    );
  }
}
