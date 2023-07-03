import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi_light.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    if (box.read("rememberMe") != null) {
      controller.emailC.text = box.read("rememberMe")["email"];
      controller.passC.text = box.read("rememberMe")["pass"];
      controller.rememeberMe.value = true;
    }
    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: AppBar(
        backgroundColor: backgroundColor1,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: backgroundColor1,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 4.625.h),
              Container(
                padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
                width: widthDevice,
                child: GradientText(
                  "NUHA",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w700, fontSize: 26.sp),
                  colors: const [buttonColor1, buttonColor2],
                ),
              ),
              SizedBox(height: 4.h),
              Container(
                padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
                width: widthDevice,
                child: Text(
                  'Selamat datang kembali!',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 17.sp,
                      color: const Color(0XFF1F1F1F)),
                ),
              ),
              SizedBox(height: 1.h),
              Container(
                padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
                width: widthDevice,
                child: Text(
                  'Untuk masuk, silahkan lengkapi dengan detail akunmu yang sudah terdaftar, ya!',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp,
                      color: grey500),
                ),
              ),
              SizedBox(height: 3.h),
              Container(
                padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
                width: widthDevice,
                child: Text(
                  'Email',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 11.sp,
                      color: grey500),
                ),
              ),
              SizedBox(height: 0.75.h),
              Container(
                padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
                width: widthDevice,
                child: TextField(
                  autocorrect: false,
                  controller: controller.emailC,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: buttonColor1,
                  textInputAction: TextInputAction.next,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 11.sp),
                  decoration: InputDecoration(
                    hintText: 'Nuha@gmail.com',
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 11.sp,
                        color: grey400),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.5.h),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: grey400),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: buttonColor1),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
              SizedBox(height: 2.5.h),
              Container(
                padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
                width: widthDevice,
                child: Text(
                  'Kata Sandi',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 11.sp,
                      color: grey500),
                ),
              ),
              SizedBox(height: 0.75.h),
              Container(
                padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
                width: widthDevice,
                child: Obx(
                  () => TextField(
                    obscureText: controller.isHidden.value,
                    autocorrect: false,
                    controller: controller.passC,
                    cursorColor: buttonColor1,
                    textInputAction: TextInputAction.done,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w400, fontSize: 11.sp),
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
                          borderSide:
                              const BorderSide(width: 1, color: grey400),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2, color: buttonColor1),
                          borderRadius: BorderRadius.circular(20)),
                      suffixIcon: IconButton(
                        onPressed: () => controller.isHidden.toggle(),
                        icon: Iconify(
                          controller.isHidden.isTrue
                              ? MdiLight.eye_off
                              : MdiLight.eye,
                          color: grey400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 0.75.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 11.1.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 24.0,
                          width: 24.0,
                          child: Theme(
                            data:
                                ThemeData(unselectedWidgetColor: buttonColor1),
                            child: Obx(
                              () => Checkbox(
                                activeColor: buttonColor1,
                                value: controller.rememeberMe.value,
                                onChanged: (value) =>
                                    controller.rememeberMe.toggle(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2.76.w),
                        Text(
                          "Remember Me",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: grey500,
                            fontSize: 9.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 11.1.w),
                    child: TextButton(
                      onPressed: () => Get.toNamed(Routes.RESET_PASSWORD),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Lupa Kata Sandi?',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 9.sp,
                            color: buttonColor1),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 23.3.h),
              Container(
                padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Belum punya akun? ',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 9.sp,
                          color: const Color(0xFF919191),
                          fontWeight: FontWeight.w400,
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.toNamed(Routes.REGISTER),
                        text: 'Daftar',
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
              SizedBox(height: 1.h),
              Container(
                width: widthDevice,
                padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
                child: SizedBox(
                  width: 77.78.w,
                  height: 5.5.h,
                  child: Obx(
                    () => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: controller.isLoading.isFalse
                          ? Text(
                              "Masuk",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontStyle: FontStyle.normal),
                            )
                          : SizedBox(
                              height: 1.5.h,
                              width: 1.5.h,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                      onPressed: () {
                        if (controller.isLoading.isFalse) {
                          controller.login();
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              Container(
                width: widthDevice,
                padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
                child: SizedBox(
                  width: 77.78.w,
                  height: 5.5.h,
                  child: Obx(
                    () => OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          foregroundColor: buttonColor1,
                          backgroundColor: backgroundColor1,
                          side: const BorderSide(color: buttonColor1, width: 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: controller.isLoadingG.isFalse
                          ? Wrap(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/google-sign-in-logo.png',
                                  height: 2.5.h,
                                  width: 2.5.h,
                                ),
                                SizedBox(width: 5.56.w),
                                Text(
                                  "Masuk dengan Google",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11.sp,
                                          color: buttonColor1,
                                          fontStyle: FontStyle.normal),
                                ),
                              ],
                            )
                          : SizedBox(
                              height: 1.5.h,
                              width: 1.5.h,
                              child: const CircularProgressIndicator(
                                color: buttonColor1,
                              ),
                            ),
                      onPressed: () {
                        if (controller.isLoadingG.isFalse) {
                          controller.registerWithGoogle();
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
