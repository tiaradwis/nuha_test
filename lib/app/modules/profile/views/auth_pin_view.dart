import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/profile/controllers/pin_controller.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

class AuthPinView extends GetView {
  AuthPinView({Key? key}) : super(key: key);
  final c = Get.find<PinController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(4.4.w, 10.h, 4.4.w, 5.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Verifikasi Identitasmu',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 19.sp,
                        color: titleColor),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Masukkan PIN kamu sebanyak 6 digit untuk menyelesaikan proses login ini!',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 13.sp,
                        color: grey500),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.h),
                  Center(
                    child: Form(
                      key: c.authPinKey,
                      child: SafeArea(
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Pinput(
                            length: 6,
                            errorTextStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: errColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp),
                            controller: c.authPinController,
                            focusNode: c.authPinNode,
                            defaultPinTheme: c.defaultPinTheme,
                            validator: (value) {
                              return value == c.myPIN.value
                                  ? null
                                  : 'Pin anda salah';
                            },
                            hapticFeedbackType: HapticFeedbackType.lightImpact,
                            onCompleted: (pin) {
                              debugPrint('onCompleted: $pin');
                            },
                            onChanged: (value) {
                              debugPrint('onChanged: $value');
                            },
                            cursor: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 9),
                                  width: 22,
                                  height: 1,
                                  color: c.focusedBorderColor,
                                ),
                              ],
                            ),
                            focusedPinTheme: c.defaultPinTheme.copyWith(
                              decoration:
                                  c.defaultPinTheme.decoration!.copyWith(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: c.focusedBorderColor),
                              ),
                            ),
                            submittedPinTheme: c.defaultPinTheme.copyWith(
                              decoration:
                                  c.defaultPinTheme.decoration!.copyWith(
                                color: c.fillColor,
                                borderRadius: BorderRadius.circular(19),
                                border: Border.all(color: c.focusedBorderColor),
                              ),
                            ),
                            errorPinTheme: c.defaultPinTheme.copyBorderWith(
                              border: Border.all(color: Colors.redAccent),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor1,
                  ),
                  onPressed: () {
                    if (c.authPinController.text != c.myPIN.value) {
                      c.authPinController.clear();
                      ScaffoldMessenger.of(Get.context!).showSnackBar(
                        const SnackBar(
                            content: Text('Masukkan PIN dengan benar')),
                      );
                    } else {
                      c.authPinNode.unfocus();
                      c.authPinKey.currentState!.validate();
                      Get.offAllNamed(Get.arguments);
                    }
                  },
                  child: Text('Kirim',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 13.sp,
                          color: backgroundColor1)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
