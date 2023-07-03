import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi_light.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/profile/controllers/profile_controller.dart';
import 'package:sizer/sizer.dart';

class GantiKataSandiView extends GetView {
  GantiKataSandiView({Key? key}) : super(key: key);

  final c = Get.find<ProfileController>(tag: 'ganti-kata-sandi');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor2,
        appBar: AppBar(
          backgroundColor: backgroundColor1,
          centerTitle: true,
          title: Text(
            'Ganti Kata Sandi',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                  color: titleColor,
                ),
          ),
          iconTheme: const IconThemeData(color: titleColor),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: backgroundColor1,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          elevation: 0.5,
          toolbarHeight: 7.375.h,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 3.5.h),
              Center(
                child: Card(
                  elevation: 0.3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  color: backgroundColor1,
                  child: SizedBox(
                    height: 36.325.h,
                    width: 84.4.w,
                    child: Column(
                      children: [
                        SizedBox(height: 2.5.h),
                        Container(
                          padding: EdgeInsets.only(right: 4.4.w, left: 4.4.w),
                          width: widthDevice,
                          child: Text(
                            'Kata Sandi Saat Ini',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11.sp,
                                    color: grey900),
                          ),
                        ),
                        SizedBox(height: 0.75.h),
                        Container(
                          padding: EdgeInsets.only(right: 4.4.w, left: 4.4.w),
                          width: widthDevice,
                          child: Obx(
                            () => TextField(
                              autocorrect: false,
                              obscureText: c.oldpassHidden.value,
                              controller: c.oldpassC,
                              cursorColor: buttonColor1,
                              textInputAction: TextInputAction.next,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11.sp),
                              decoration: InputDecoration(
                                hintText: 'min. 8 karakter',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11.sp,
                                        color: grey400),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 2.h, vertical: 1.5.h),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: grey50),
                                    borderRadius: BorderRadius.circular(20)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: buttonColor1),
                                    borderRadius: BorderRadius.circular(20)),
                                suffixIcon: IconButton(
                                  onPressed: () => c.oldpassHidden.toggle(),
                                  icon: Iconify(
                                    c.oldpassHidden.isTrue
                                        ? MdiLight.eye_off
                                        : MdiLight.eye,
                                    color: grey400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Container(
                          padding: EdgeInsets.only(right: 4.4.w, left: 4.4.w),
                          width: widthDevice,
                          child: Text(
                            'Kata Sandi Baru',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11.sp,
                                    color: grey900),
                          ),
                        ),
                        SizedBox(height: 0.75.h),
                        Container(
                          padding: EdgeInsets.only(right: 4.4.w, left: 4.4.w),
                          width: widthDevice,
                          child: Obx(
                            () => TextField(
                              autocorrect: false,
                              obscureText: c.newpassHidden.value,
                              controller: c.newpassC,
                              cursorColor: buttonColor1,
                              textInputAction: TextInputAction.next,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11.sp),
                              decoration: InputDecoration(
                                hintText: 'min. 8 karakter',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11.sp,
                                        color: grey400),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 2.h, vertical: 1.5.h),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: grey50),
                                    borderRadius: BorderRadius.circular(20)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: buttonColor1),
                                    borderRadius: BorderRadius.circular(20)),
                                suffixIcon: IconButton(
                                  onPressed: () => c.newpassHidden.toggle(),
                                  icon: Iconify(
                                    c.newpassHidden.isTrue
                                        ? MdiLight.eye_off
                                        : MdiLight.eye,
                                    color: grey400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Container(
                          padding: EdgeInsets.only(right: 4.4.w, left: 4.4.w),
                          width: widthDevice,
                          child: Text(
                            'Konfirmasi Kata Sandi Baru',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11.sp,
                                    color: grey900),
                          ),
                        ),
                        SizedBox(height: 0.75.h),
                        Container(
                          padding: EdgeInsets.only(right: 4.4.w, left: 4.4.w),
                          width: widthDevice,
                          child: Obx(
                            () => TextField(
                              autocorrect: false,
                              obscureText: c.connewpassHidden.value,
                              controller: c.connewpassC,
                              cursorColor: buttonColor1,
                              textInputAction: TextInputAction.done,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11.sp),
                              decoration: InputDecoration(
                                hintText: 'min. 8 karakter',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11.sp,
                                        color: grey400),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 2.h, vertical: 1.5.h),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: grey50),
                                    borderRadius: BorderRadius.circular(20)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: buttonColor1),
                                    borderRadius: BorderRadius.circular(20)),
                                suffixIcon: IconButton(
                                  onPressed: () => c.connewpassHidden.toggle(),
                                  icon: Iconify(
                                    c.connewpassHidden.isTrue
                                        ? MdiLight.eye_off
                                        : MdiLight.eye,
                                    color: grey400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 39.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.056.w),
                height: 5.5.h,
                width: widthDevice,
                child: Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      if (c.isLoading.isFalse) {
                        c.updatePassword();
                      }
                    },
                    child: c.isLoading.isFalse
                        ? Text(
                            'Simpan',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11.sp,
                                    color: backgroundColor1),
                          )
                        : SizedBox(
                            height: 1.25.h,
                            width: 1.25.h,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
