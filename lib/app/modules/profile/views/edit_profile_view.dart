import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/profile/controllers/profile_controller.dart';
import 'package:sizer/sizer.dart';

class EditProfileView extends GetView {
  EditProfileView({Key? key}) : super(key: key);

  final c = Get.find<ProfileController>(tag: 'edit-profile');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor2,
        appBar: AppBar(
          backgroundColor: backgroundColor1,
          centerTitle: true,
          title: Text(
            'Edit Akun',
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
            if (snapshot.data == null) {
              return const Center(
                child: Text("Tidak ada data user."),
              );
            } else {
              c.emailC.text = snapshot.data!["email"];
              c.nameC.text = snapshot.data!["name"];
              c.phoneC.text = snapshot.data!["phone"];
              c.bdayC.text = snapshot.data!["tgl_lahir"];
              c.workC.text = snapshot.data!["pekerjaan"];
              return SingleChildScrollView(
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
                          height: 59.375.h,
                          width: 84.4.w,
                          child: Column(
                            children: [
                              SizedBox(height: 2.5.h),
                              Container(
                                padding:
                                    EdgeInsets.only(right: 4.4.w, left: 4.4.w),
                                width: widthDevice,
                                child: Text(
                                  'Nama Lengkap',
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
                                padding:
                                    EdgeInsets.only(right: 4.4.w, left: 4.4.w),
                                width: widthDevice,
                                child: TextField(
                                  autocorrect: false,
                                  controller: c.nameC,
                                  cursorColor: buttonColor1,
                                  textInputAction: TextInputAction.next,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11.sp),
                                  decoration: InputDecoration(
                                    hintText: 'Masukkan Nama Lengkap Anda',
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 2, color: buttonColor1),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Container(
                                padding:
                                    EdgeInsets.only(right: 4.4.w, left: 4.4.w),
                                width: widthDevice,
                                child: Text(
                                  'Email',
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
                                padding:
                                    EdgeInsets.only(right: 4.4.w, left: 4.4.w),
                                width: widthDevice,
                                child: TextField(
                                  readOnly: true,
                                  enabled: false,
                                  autocorrect: false,
                                  controller: c.emailC,
                                  keyboardType: TextInputType.emailAddress,
                                  cursorColor: buttonColor1,
                                  textInputAction: TextInputAction.next,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11.sp),
                                  decoration: InputDecoration(
                                    hintText: 'Masukkan Alamat Email Anda',
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 2, color: buttonColor1),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    disabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: grey50),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Container(
                                padding:
                                    EdgeInsets.only(right: 4.4.w, left: 4.4.w),
                                width: widthDevice,
                                child: Text(
                                  'Nomor Telepon',
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
                                padding:
                                    EdgeInsets.only(right: 4.4.w, left: 4.4.w),
                                width: widthDevice,
                                child: TextField(
                                  autocorrect: false,
                                  controller: c.phoneC,
                                  keyboardType: TextInputType.number,
                                  cursorColor: buttonColor1,
                                  textInputAction: TextInputAction.next,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11.sp),
                                  decoration: InputDecoration(
                                    hintText: 'Masukkan Nomor Telepon Anda',
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 2, color: buttonColor1),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Container(
                                padding:
                                    EdgeInsets.only(right: 4.4.w, left: 4.4.w),
                                width: widthDevice,
                                child: Text(
                                  'Tanggal Lahir',
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
                                  padding: EdgeInsets.only(
                                      right: 4.4.w, left: 4.4.w),
                                  width: widthDevice,
                                  child: InkWell(
                                    onTap: () => c.chooseDate(),
                                    child: IgnorePointer(
                                      child: TextField(
                                        autocorrect: false,
                                        controller: c.bdayC,
                                        keyboardType: TextInputType.datetime,
                                        cursorColor: buttonColor1,
                                        textInputAction: TextInputAction.next,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.sp),
                                        decoration: InputDecoration(
                                          hintText:
                                              'Masukkan tanggal lahir anda',
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
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 2,
                                                  color: buttonColor1),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          suffixIcon: Icon(
                                            Icons.date_range,
                                            color: grey400,
                                            size: 2.5.h,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                              SizedBox(height: 1.h),
                              Container(
                                padding:
                                    EdgeInsets.only(right: 4.4.w, left: 4.4.w),
                                width: widthDevice,
                                child: Text(
                                  'Pekerjaan',
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
                                padding:
                                    EdgeInsets.only(right: 4.4.w, left: 4.4.w),
                                width: widthDevice,
                                child: TextField(
                                  autocorrect: false,
                                  controller: c.workC,
                                  cursorColor: buttonColor1,
                                  textInputAction: TextInputAction.done,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11.sp),
                                  decoration: InputDecoration(
                                    hintText: 'Masukkan Nama Pekerjaan Anda',
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 2, color: buttonColor1),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
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
                                    c.updateProfile();
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
                ),
              );
            }
          },
        ));
  }
}
