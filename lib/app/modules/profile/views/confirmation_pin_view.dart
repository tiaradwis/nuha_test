import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/profile/controllers/pin_controller.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

class ConfirmationPinView extends GetView {
  ConfirmationPinView({Key? key}) : super(key: key);
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
                    'Konfirmasi PIN Baru Kamu',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 19.sp,
                        color: titleColor),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Pastikan konfirmai PIN yang kamu masukkan cocok dengan PIN baru yang kamu buat!',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 13.sp,
                        color: grey500),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.h),
                  Center(
                    child: Form(
                      key: c.conFormKey,
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
                            controller: c.confirmNewPinController,
                            focusNode: c.confirmNewPinNode,
                            defaultPinTheme: c.defaultPinTheme,
                            hapticFeedbackType: HapticFeedbackType.lightImpact,
                            onCompleted: (pin) {
                              debugPrint('onCompleted: $pin');
                            },
                            onChanged: (value) {
                              debugPrint('onChanged: $value');
                            },
                            validator: (value) {
                              return value == c.newpinController.text
                                  ? null
                                  : 'Pin kamu tidak cocok';
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
                    if (c.confirmNewPinController.text.isEmpty ||
                        c.confirmNewPinController.length < 6) {
                      ScaffoldMessenger.of(Get.context!).showSnackBar(
                        const SnackBar(
                            content: Text('Masukkan PIN dengan benar')),
                      );
                    } else {
                      if (c.confirmNewPinController.text !=
                          c.newpinController.text) {
                        ScaffoldMessenger.of(Get.context!).showSnackBar(
                          const SnackBar(content: Text('Pin tidak cocok')),
                        );
                      } else {
                        c.confirmNewPinNode.unfocus();
                        c.conFormKey.currentState!.validate();
                        c.createUserPin(c.confirmNewPinController.text);
                      }
                    }
                  },
                  child: Text(
                    'Konfirmasi PIN',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 13.sp,
                        color: backgroundColor1),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
