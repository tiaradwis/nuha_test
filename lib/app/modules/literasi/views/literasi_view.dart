import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/literasi/views/list_artikel_view.dart';
import 'package:nuha/app/modules/literasi/views/list_video_view.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'package:sizer/sizer.dart';
import '../controllers/literasi_controller.dart';

class LiterasiView extends GetView<LiterasiController> {
  const LiterasiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      appBar: AppBar(
        backgroundColor: backgroundColor1,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(left: 4.6.w),
          child: Text(
            'Literasi',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.w600, fontSize: 13.sp),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 4.6.w),
            child: IconButton(
              onPressed: () => Get.toNamed(Routes.BOOKMARKED),
              icon: Iconify(
                MaterialSymbols.bookmark_outline,
                size: 18.sp,
                color: titleColor,
              ),
            ),
          ),
        ],
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
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: backgroundColor1,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        elevation: 0.5,
        toolbarHeight: 7.375.h,
      ),
      body: TabBarView(
        controller: controller.tabs,
        children: [
          ListArtikelView(),
          ListVideoView(),
        ],
      ),
    );
  }
}
