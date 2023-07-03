import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/literasi/controllers/bookmarked_controller.dart';
import 'package:nuha/app/modules/literasi/views/bookmarked_artikel_view.dart';
import 'package:nuha/app/modules/literasi/views/bookmarked_video_view.dart';
import 'package:sizer/sizer.dart';

class BookmarkedView extends GetView<BookmarkedController> {
  const BookmarkedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      appBar: AppBar(
        backgroundColor: backgroundColor1,
        leading: Container(
          width: 100,
          padding: EdgeInsets.only(left: 4.58.w),
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Iconify(
              Mdi.arrow_left,
              size: 3.h,
              color: titleColor,
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          color: titleColor,
        ),
        centerTitle: true,
        title: Text(
          'Bookmark Artikel',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600, fontSize: 13.sp, color: titleColor),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: backgroundColor1,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        elevation: 0.5,
        toolbarHeight: 7.375.h,
        bottom: TabBar(
          indicatorWeight: 3,
          labelColor: buttonColor1,
          indicatorColor: buttonColor1,
          controller: controller.tabs,
          tabs: controller.literasiTabs,
          labelStyle: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w600, fontSize: 11.sp),
          unselectedLabelColor: grey400,
          unselectedLabelStyle: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w400, fontSize: 11.sp),
        ),
      ),
      body: TabBarView(
        controller: controller.tabs,
        children: [
          BookmarkedArtikelView(),
          BookmarkedVideoView(),
        ],
      ),
    );
  }
}
