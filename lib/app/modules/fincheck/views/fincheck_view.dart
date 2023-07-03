import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/fincheck/views/fincheck_satu_view.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';

import '../controllers/fincheck_controller.dart';

class FincheckView extends StatelessWidget {
  FincheckView({Key? key}) : super(key: key);
  // final appBarheight = AppBar().preferredSize.height;

  final controller = Get.find<FincheckController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(5.875.h),
        child: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
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
              children: [
                GradientText(
                  "Ulas Kondisi Kesehatan Finansialmu",
                  style: Theme.of(context).textTheme.displayMedium!,
                  colors: const [
                    buttonColor1,
                    buttonColor2,
                  ],
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Text(
                  "Financial Check Up merupakan sebuah upaya pemeriksaaan atau pengecekan kondisi keuangan untuk jangka waktu tertentu.",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: grey500),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 3.625.h,
          ),
          SizedBox(
            width: 100.w,
            child: Center(
              child: SizedBox(
                width: 84.1667.w,
                height: 5.5.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Text(
                    "Lakukan Tes",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                  onPressed: () => Get.to(const FincheckSatuView()),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
