import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/gg.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/mdi_light.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'package:sizer/sizer.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF8F8F8),
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
          // Background with gradient
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [buttonColor1, buttonColor2],
              ),
            ),
            height: 38.25.h,
          ),
          //Content
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: controller.streamProfile(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircleAvatar(
                    backgroundColor: Colors.grey[400],
                  );
                }
                Map<String, dynamic>? data = snapshot.data!.data();
                return Column(
                  children: <Widget>[
                    SizedBox(height: 12.125.h),
                    Center(
                      child: SizedBox(
                          height: 10.h,
                          width: 10.h,
                          child: Stack(
                            clipBehavior: Clip.none,
                            fit: StackFit.expand,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey[400],
                                backgroundImage: NetworkImage(
                                  data?["profile"] != null
                                      ? snapshot.data!["profile"].toString()
                                      : "https://ui-avatars.com/api/?name=${data!["name"]}",
                                ),
                              ),
                              Positioned(
                                bottom: -5,
                                right: -23,
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 3,
                                      color: Colors.white,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50)),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: SizedBox(
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () => Get.toNamed(
                                            Routes.GANTI_FOTO_PROFIL),
                                        color: buttonColor1,
                                        iconSize: 18,
                                        icon: const Icon(Icons.add_a_photo,
                                            color: buttonColor1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(height: 1.h),
                    Center(
                      child: Text(
                        data!["name"],
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              color: backgroundColor1,
                            ),
                      ),
                    ),
                    Center(
                      child: Text(
                        data["email"],
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 11.sp,
                              color: backgroundColor1,
                            ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      color: backgroundColor1,
                      child: SizedBox(
                        height: 41.975.h,
                        width: 84.4.w,
                        child: Column(
                          children: [
                            SizedBox(height: 2.5.h),
                            Container(
                              width: widthDevice,
                              padding: EdgeInsets.symmetric(horizontal: 4.4.w),
                              child: Text(
                                'Pengaturan Akun',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: titleColor,
                                      fontSize: 11.sp,
                                    ),
                              ),
                            ),
                            SizedBox(height: 1.5.h),
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
                                leading: const Iconify(
                                  Gg.profile,
                                  size: 24,
                                  color: titleColor,
                                ),
                                trailing: const Iconify(
                                  Bi.chevron_right,
                                  size: 24,
                                  color: titleColor,
                                ),
                                title: Text(
                                  'Edit Akun',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 9.sp,
                                        color: titleColor,
                                      ),
                                ),
                                onTap: () => Get.toNamed(Routes.PIN,
                                    arguments: Routes.EDIT_PROFILE),
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
                                leading: const Iconify(
                                  Mdi.diamond_stone,
                                  size: 24,
                                  color: titleColor,
                                ),
                                trailing: const Iconify(
                                  Bi.chevron_right,
                                  size: 24,
                                  color: titleColor,
                                ),
                                title: Text(
                                  'Upgrade Akun',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 9.sp,
                                        color: titleColor,
                                      ),
                                ),
                                onTap: () {},
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
                                leading: const Iconify(
                                  Ph.lock,
                                  size: 20,
                                  color: titleColor,
                                ),
                                trailing: const Iconify(
                                  Bi.chevron_right,
                                  size: 24,
                                  color: titleColor,
                                ),
                                title: Text(
                                  'Pengaturan Keamanan',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 9.sp,
                                        color: titleColor,
                                      ),
                                ),
                                onTap: () =>
                                    Get.toNamed(Routes.PENGATURAN_KEAMANAN),
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
                                leading: const Iconify(
                                  Ph.bell,
                                  size: 20,
                                  color: titleColor,
                                ),
                                trailing: const Iconify(
                                  Bi.chevron_right,
                                  size: 24,
                                  color: titleColor,
                                ),
                                title: Text(
                                  'Pengaturan Notifikasi',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 9.sp,
                                        color: titleColor,
                                      ),
                                ),
                                onTap: () =>
                                    Get.toNamed(Routes.PENGATURAN_NOTIFIKASI),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      color: backgroundColor1,
                      child: SizedBox(
                        height: 41.975.h,
                        width: 84.4.w,
                        child: Column(
                          children: [
                            SizedBox(height: 2.5.h),
                            Container(
                              width: widthDevice,
                              padding: EdgeInsets.symmetric(horizontal: 4.4.w),
                              child: Text(
                                'Informasi',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: titleColor,
                                      fontSize: 11.sp,
                                    ),
                              ),
                            ),
                            SizedBox(height: 1.5.h),
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
                                leading: const Iconify(
                                  MdiLight.help_circle,
                                  size: 24,
                                  color: titleColor,
                                ),
                                trailing: const Iconify(
                                  Bi.chevron_right,
                                  size: 24,
                                  color: titleColor,
                                ),
                                title: Text(
                                  'Bantuan',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 9.sp,
                                        color: titleColor,
                                      ),
                                ),
                                onTap: () {},
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
                                leading: const Iconify(
                                  MdiLight.information,
                                  size: 24,
                                  color: titleColor,
                                ),
                                trailing: const Iconify(
                                  Bi.chevron_right,
                                  size: 24,
                                  color: titleColor,
                                ),
                                title: Text(
                                  'Syarat & Ketentuan',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 9.sp,
                                        color: titleColor,
                                      ),
                                ),
                                onTap: () {},
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
                                leading: const Iconify(
                                  Ph.chat_circle_dots_light,
                                  size: 24,
                                  color: titleColor,
                                ),
                                trailing: const Iconify(
                                  Bi.chevron_right,
                                  size: 24,
                                  color: titleColor,
                                ),
                                title: Text(
                                  'Hubungi Kami',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 9.sp,
                                        color: titleColor,
                                      ),
                                ),
                                onTap: () {},
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
                                leading: const Iconify(
                                  Ph.x_circle_thin,
                                  size: 24,
                                  color: titleColor,
                                ),
                                trailing: const Iconify(
                                  Bi.chevron_right,
                                  size: 24,
                                  color: titleColor,
                                ),
                                title: Text(
                                  'Hapus Akun',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 9.sp,
                                        color: titleColor,
                                      ),
                                ),
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 3.5.h),
                    Container(
                      padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
                      child: SizedBox(
                        width: widthDevice,
                        height: 5.5.h,
                        child: auth.currentUser!.providerData[0].providerId ==
                                'google.com'
                            ? Obx(
                                () => OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      foregroundColor: const Color(0XFFCC444B),
                                      backgroundColor: backgroundColor2,
                                      side: const BorderSide(
                                          color: Color(0XFFCC444B), width: 1),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  child: controller.isLoading.isFalse
                                      ? Text(
                                          "Keluar",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 11.sp,
                                                  color:
                                                      const Color(0XFFCC444B),
                                                  fontStyle: FontStyle.normal),
                                        )
                                      : SizedBox(
                                          height: 1.5.h,
                                          width: 1.5.h,
                                          child:
                                              const CircularProgressIndicator(
                                            color: Color(0XFFCC444B),
                                          ),
                                        ),
                                  onPressed: () {
                                    if (controller.isLoading.isFalse) {
                                      controller.logoutGoogle();
                                    }
                                  },
                                ),
                              )
                            : Obx(
                                () => OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      foregroundColor: const Color(0XFFCC444B),
                                      backgroundColor: backgroundColor2,
                                      side: const BorderSide(
                                          color: Color(0XFFCC444B), width: 1),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  child: controller.isLoading.isFalse
                                      ? Text(
                                          "Keluar",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 11.sp,
                                                  color:
                                                      const Color(0XFFCC444B),
                                                  fontStyle: FontStyle.normal),
                                        )
                                      : SizedBox(
                                          height: 1.5.h,
                                          width: 1.5.h,
                                          child:
                                              const CircularProgressIndicator(
                                            color: Color(0XFFCC444B),
                                          ),
                                        ),
                                  onPressed: () {
                                    if (controller.isLoading.isFalse) {
                                      controller.logout();
                                    }
                                  },
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 3.53125.h),
                  ],
                );
              }),
          // Positioned to take only AppBar size
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                "Profil",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: backgroundColor1,
                    ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
