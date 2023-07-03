import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/profile/controllers/notification_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_switch/flutter_switch.dart';

class PengaturanNotifikasiView extends GetView {
  PengaturanNotifikasiView({Key? key}) : super(key: key);
  final notifC = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor2,
        appBar: AppBar(
          backgroundColor: backgroundColor1,
          centerTitle: true,
          title: Text(
            'Pengaturan Notifikasi',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
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
        body: Column(
          children: [
            SizedBox(height: 2.25.h),
            Center(
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                color: backgroundColor1,
                child: SizedBox(
                  height: 29.475.h,
                  width: 84.4.w,
                  child: Column(
                    children: [
                      SizedBox(height: 2.5.h),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Color(0XFFF1F1F1),
                            ),
                          ),
                        ),
                        width: widthDevice,
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pengingat Konten Terbaru Literasi',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 9.sp,
                                      color: grey900,
                                    ),
                              ),
                              Obx(
                                () => FlutterSwitch(
                                  width: 36.0,
                                  height: 22.0,
                                  toggleSize: 15.0,
                                  value: notifC.isLiterasiOn.value,
                                  activeColor: buttonColor2,
                                  inactiveColor: grey400,
                                  onToggle: (value) async {
                                    notifC.isLiterasiOn.value = value;
                                    await notifC
                                        .scheduleLiterationNotification(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Color(0XFFF1F1F1),
                            ),
                          ),
                        ),
                        width: widthDevice,
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pengingat Pencatatan Alur Kas',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 9.sp,
                                      color: grey900,
                                    ),
                              ),
                              Obx(
                                () => FlutterSwitch(
                                    width: 36.0,
                                    height: 22.0,
                                    toggleSize: 15.0,
                                    value: notifC.isCashFlowOn.value,
                                    activeColor: buttonColor2,
                                    inactiveColor: grey400,
                                    onToggle: (value) async {
                                      notifC.isCashFlowOn.value = value;
                                      await notifC
                                          .scheduleCashflowNotification(value);
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Color(0XFFF1F1F1),
                            ),
                          ),
                        ),
                        width: widthDevice,
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pengingat Zakat',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 9.sp,
                                      color: grey900,
                                    ),
                              ),
                              Obx(
                                () => FlutterSwitch(
                                  width: 36.0,
                                  height: 22.0,
                                  toggleSize: 15.0,
                                  value: notifC.isZakatOn.value,
                                  activeColor: buttonColor2,
                                  inactiveColor: grey400,
                                  onToggle: (value) async {
                                    notifC.isZakatOn.value = value;
                                    await notifC
                                        .scheduleZakatNotification(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
