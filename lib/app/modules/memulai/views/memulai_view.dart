import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';
import '../controllers/memulai_controller.dart';

class MemulaiView extends GetView<MemulaiController> {
  const MemulaiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: backgroundColor1,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 4.625.h),
            Center(
              child: GradientText(
                "NUHA",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 34),
                colors: const [buttonColor1, buttonColor2],
              ),
            ),
            SizedBox(height: 9.5.h),
            SizedBox(
              width: 63.3.w,
              child: Image.asset('assets/images/Book Lovers.png'),
            ),
            SizedBox(height: 10.5.h),
            Container(
              width: widthDevice,
              padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
              child: Text(
                'Selamat datang di Nuha!',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 17.sp,
                      color: grey900,
                    ),
              ),
            ),
            SizedBox(height: 1.h),
            Container(
              width: widthDevice,
              padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
              child: Text(
                'Mari bergabung dengan Nuha untuk peningkatan finansial berdasarkan syariat islam.',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    color: const Color(0XFF717171)),
              ),
            ),
            SizedBox(height: 5.375.h),
            Container(
              width: widthDevice,
              padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
              child: SizedBox(
                width: 77.78.w,
                height: 5.5.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Text(
                    "Daftar",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontStyle: FontStyle.normal),
                  ),
                  onPressed: () => Get.toNamed(Routes.REGISTER),
                ),
              ),
            ),
            SizedBox(height: 1.5.h),
            Container(
              width: widthDevice,
              padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
              child: SizedBox(
                width: 77.78.w,
                height: 5.5.h,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      foregroundColor: buttonColor1,
                      backgroundColor: backgroundColor1,
                      side: const BorderSide(color: buttonColor1, width: 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Text(
                    "Masuk",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 13.sp,
                        color: buttonColor1,
                        fontStyle: FontStyle.normal),
                  ),
                  onPressed: () => Get.toNamed(Routes.LOGIN),
                ),
              ),
            ),
            SizedBox(height: 1.25.h),
            Container(
              padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
              width: widthDevice,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text:
                      'Dengan masuk atau melakukan pendaftaran, kamu menyetujui ',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 9.sp,
                        color: const Color(0xFF919191),
                        fontWeight: FontWeight.w400,
                      ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Ketentuan Layanan ',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 9.sp,
                            color: buttonColor1,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    TextSpan(
                      text: 'dan ',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 9.sp,
                            color: const Color(0xFF919191),
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    TextSpan(
                      text: 'Kebijakan Privasi',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 9.sp,
                            color: buttonColor1,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
