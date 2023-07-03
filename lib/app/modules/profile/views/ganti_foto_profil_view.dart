import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/profile/controllers/profile_controller.dart';
import 'package:sizer/sizer.dart';

class GantiFotoProfilView extends GetView {
  GantiFotoProfilView({Key? key}) : super(key: key);
  final c = Get.find<ProfileController>(tag: 'ganti-foto-profil');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      appBar: AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
        title: Text(
          'Ganti Foto Profil',
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
      body: FutureBuilder<Map<String, dynamic>?>(
          future: c.getProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: buttonColor1),
              );
            }
            return Column(
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
                      height: 38.h,
                      width: 84.4.w,
                      child: Column(
                        children: [
                          SizedBox(height: 2.5.h),
                          Container(
                            padding: EdgeInsets.only(right: 4.4.w, left: 4.4.w),
                            child: GetBuilder<ProfileController>(
                              init: ProfileController(),
                              tag: 'ganti-foto-profil',
                              builder: (choose) {
                                return choose.image != null
                                    ? Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                right: 4.4.w, left: 4.4.w),
                                            width: 150,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.grey[400],
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(
                                                    File(choose.image!.path)),
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                choose.resetImage(),
                                            child: Text(
                                              'Hapus',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    color: buttonColor1,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : snapshot.data?["profile"] != null &&
                                            choose.profile.isTrue
                                        ? Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    right: 4.4.w, left: 4.4.w),
                                                width: 150,
                                                height: 150,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color: Colors.grey[400],
                                                  image: DecorationImage(
                                                    image: NetworkImage(snapshot
                                                        .data!["profile"]),
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Get.defaultDialog(
                                                    title: 'Peringatan',
                                                    titleStyle:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .headlineSmall,
                                                    middleText:
                                                        "Apakah kamu yakin untuk menghapus foto profile ?",
                                                    middleTextStyle:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium,
                                                    actions: [
                                                      OutlinedButton(
                                                        onPressed: () =>
                                                            Get.back(),
                                                        child: Text("Tidak",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelLarge),
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    buttonColor1),
                                                        onPressed: () => choose
                                                            .clearProfile(),
                                                        child: Text(
                                                          "Ya",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .labelLarge!
                                                              .copyWith(
                                                                  color:
                                                                      backgroundColor1),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                                child: Text(
                                                  'Hapus Profil',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                        color: buttonColor1,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ),
                                              SizedBox(height: 1.h),
                                              SizedBox(
                                                width: widthDevice,
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                buttonColor1),
                                                    onPressed: () =>
                                                        choose.pickImage(),
                                                    child: Text(
                                                      'Ubah Foto Profil',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge!
                                                          .copyWith(
                                                              color:
                                                                  backgroundColor1),
                                                    )),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    right: 4.4.w, left: 4.4.w),
                                                width: 150,
                                                height: 150,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color: Colors.grey[400],
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                        "https://ui-avatars.com/api/?name=${snapshot.data!["name"]}",
                                                      )),
                                                ),
                                              ),
                                              SizedBox(height: 7.5.h),
                                              SizedBox(
                                                width: widthDevice,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              buttonColor1),
                                                  onPressed: () =>
                                                      choose.pickImage(),
                                                  child: Text(
                                                    'Ubah Foto Profil',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelLarge!
                                                        .copyWith(
                                                          color:
                                                              backgroundColor1,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 37.5.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.056.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 5.5.h,
                        width: 39.167.w,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              foregroundColor: buttonColor2,
                              backgroundColor: backgroundColor2,
                              side: const BorderSide(
                                  color: buttonColor2, width: 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () => Get.back(),
                          child: Text(
                            'Batalkan',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11.sp,
                                    color: buttonColor2),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.5.h,
                        width: 39.167.w,
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
                                c.updateFotoProfile();
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
                )
              ],
            );
          }),
    );
  }
}
