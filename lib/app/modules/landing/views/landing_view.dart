import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'package:sizer/sizer.dart';

import '../controllers/landing_controller.dart';

class LandingView extends GetView<LandingController> {
  const LandingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 5.12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 4.44.w,
                    height: 0.5.h,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: buttonColor1),
                  ),
                  SizedBox(
                    width: 1.38.w,
                  ),
                  Container(
                    width: 4.44.w,
                    height: 0.5.h,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color(0XFFF1F1F1)),
                  ),
                  SizedBox(
                    width: 1.38.w,
                  ),
                  Container(
                    width: 4.44.w,
                    height: 0.5.h,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color(0XFFF1F1F1)),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 4.25.h),
              width: 100.w,
              height: 77.125.h,
              child: Column(
                children: [
                  Image(
                    image: const AssetImage('assets/images/landing_page.png'),
                    width: 100.w,
                    height: 32.75.h,
                    fit: BoxFit.cover,
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(11.1.w, 2.375.h, 11.1.w, 0.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Halo, Selamat datang di Nuha.",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(color: titleColor),
                              ),
                              TextSpan(
                                text: " Solusi Keuanganmu",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(color: buttonColor1),
                              ),
                            ]),
                          ),
                          SizedBox(height: 2.5.h),
                          Text(
                            "Nuha merupakan solusi keuangan yang mudah diakses kapan saja dan dimana saja. Dilengkapi dengan fitur yang pasti ngebantu banget.",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: grey500),
                          ),
                        ],
                      ))
                ],
              ),
            ),
            Container(
              // margin: EdgeInsets.symmetric(horizontal: 11.w),
              margin: EdgeInsets.fromLTRB(11.1.w, 0, 11.1.w, 6.5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 5.5.h,
                    child: TextButton(
                      child: Text(
                        "Lewati",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: grey500),
                      ),
                      onPressed: () => Get.toNamed("/memulai"),
                    ),
                  ),
                  SizedBox(
                    width: 39.7.w,
                    height: 5.5.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Text(
                        "Selanjutnya",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      onPressed: () => Get.to(() => const SecondLanding()),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondLanding extends GetView<LandingController> {
  const SecondLanding({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 5.12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 4.44.w,
                    height: 0.5.h,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: grey50),
                  ),
                  SizedBox(
                    width: 1.38.w,
                  ),
                  Container(
                    width: 4.44.w,
                    height: 0.5.h,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: buttonColor1),
                  ),
                  SizedBox(
                    width: 1.38.w,
                  ),
                  Container(
                    width: 4.44.w,
                    height: 0.5.h,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: grey50),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 4.25.h),
              width: 100.w,
              height: 77.125.h,
              child: Column(
                children: [
                  Image(
                    image: const AssetImage('assets/images/landing_page.png'),
                    width: 100.w,
                    height: 32.75.h,
                    fit: BoxFit.cover,
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(11.1.w, 2.375.h, 11.1.w, 0.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Kami Hadir Untuk Membantu Kebutuhan ",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(color: titleColor),
                              ),
                              TextSpan(
                                text: " Finansialmu",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(color: buttonColor1),
                              ),
                            ]),
                          ),
                          SizedBox(height: 2.5.h),
                          Text(
                            "Ayo tingkatkan kemampuan finansial dan wujudkan kesehatan finansial dimulai dari diri sendiri menggunakan aplikasi Nuha.",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: grey500),
                          ),
                        ],
                      ))
                ],
              ),
            ),
            Container(
              // margin: EdgeInsets.symmetric(horizontal: 11.1.w),
              margin: EdgeInsets.fromLTRB(11.1.w, 0.h, 11.1.w, 6.5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 5.5.h,
                    child: TextButton(
                      child: Text(
                        "Lewati",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: grey500),
                      ),
                      onPressed: () => Get.toNamed("/memulai"),
                    ),
                  ),
                  SizedBox(
                    width: 39.7.w,
                    height: 5.5.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Text(
                        "Selanjutnya",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      onPressed: () => Get.to(() => const ThirdLanding()),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdLanding extends GetView<LandingController> {
  const ThirdLanding({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 5.12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 4.44.w,
                    height: 0.5.h,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: grey50),
                  ),
                  SizedBox(
                    width: 1.38.w,
                  ),
                  Container(
                    width: 4.44.w,
                    height: 0.5.h,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: grey50),
                  ),
                  SizedBox(
                    width: 1.38.w,
                  ),
                  Container(
                    width: 4.44.w,
                    height: 0.5.h,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: buttonColor1),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 4.25.h),
              width: 100.w,
              height: 77.125.h,
              child: Column(
                children: [
                  Image(
                    image: const AssetImage('assets/images/landing_page.png'),
                    width: 100.w,
                    height: 32.75.h,
                    fit: BoxFit.cover,
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(11.1.w, 2.375.h, 11.1.w, 0.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text:
                                    "Kini, kamu tidak perlu repot untuk membayar ",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(color: titleColor),
                              ),
                              TextSpan(
                                text: " ZIS",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(color: buttonColor1),
                              ),
                            ]),
                          ),
                          SizedBox(height: 2.5.h),
                          Text(
                            "Aplikasi Nuha merupakan solusi keuangan untuk kamu yang ingin sekaligus menginginkan kemudahan dalam melakukan amalan.",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: grey500),
                          ),
                        ],
                      ))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(11.1.w, 0.h, 11.1.w, 6.5.h),
              child: Center(
                child: SizedBox(
                  width: 77.778.w,
                  height: 5.5.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Text(
                      "Memulai",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    onPressed: () => Get.toNamed(Routes.MEMULAI),
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
