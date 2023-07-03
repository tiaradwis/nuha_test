import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/literasi/controllers/cari_artikel_controller.dart';
import 'package:nuha/app/utility/result_state.dart';
import 'package:sizer/sizer.dart';

class CariArtikelView extends GetView<CariArtikelController> {
  CariArtikelView({Key? key}) : super(key: key);
  final c = Get.find<CariArtikelController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      appBar: AppBar(
        backgroundColor: backgroundColor1,
        iconTheme: const IconThemeData(
          color: titleColor,
        ),
        title: TextField(
          controller: c.searchC,
          cursorColor: buttonColor1,
          autocorrect: false,
          autofocus: true,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w400, fontSize: 9.sp, color: grey400),
          decoration: InputDecoration(
            hintText: 'Cari artikel disini',
            hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w400, fontSize: 9.sp, color: grey400),
            filled: true,
            fillColor: grey50,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 0, color: grey50),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 0, color: grey50),
                borderRadius: BorderRadius.circular(10)),
          ),
          onChanged: (keyword) => c.searchArtikelResult(keyword),
        ),
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 2.5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.78.w),
              child: Obx(
                () {
                  switch (c.resultState.value.status) {
                    case ResultStatus.loading:
                      return Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 35.h),
                          child: const CircularProgressIndicator(
                            color: buttonColor1,
                          ),
                        ),
                      );
                    case ResultStatus.hasData:
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: c.resultCariArtikel.founded.toInt(),
                        itemBuilder: (context, index) {
                          var artikel = c.resultCariArtikel.data[index];
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.DETAIL_ARTIKEL,
                                  arguments: artikel.id.toString());
                            },
                            child: Card(
                              color: backgroundColor2,
                              elevation: 0,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: Image.network(
                                        artikel.imageUrl,
                                        height: 8.625.h,
                                        width: 29.72.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 3.89.w),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          artikel.title,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0XFF0D4136),
                                                  fontSize: 9.sp),
                                        ),
                                        Text(
                                          timeago.format(artikel.publishedAt,
                                              locale: 'id'),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  color: grey500,
                                                  fontSize: 8.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: grey50,
                            thickness: 0.2.h,
                          );
                        },
                      );
                    case ResultStatus.noData:
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 30.h),
                        child: Column(
                          children: [
                            Image.asset('assets/images/404_error.png'),
                            SizedBox(height: 2.5.h),
                            Text(
                              'Maaf, artikel yang kamu cari tidak ditemukan. Silahkan coba lagi dengan menggunakan kata kunci yang berbeda.',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                      fontSize: 9.sp,
                                      fontWeight: FontWeight.w400,
                                      color: grey500),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    case ResultStatus.error:
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 17.083.w, vertical: 35.h),
                        child: Text(
                          'Mulai temukan artikel yang kamu cari! Cukup masukkan kata kunci atau topik yang kamu inginkan.',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w400,
                                  color: grey500),
                          textAlign: TextAlign.center,
                        ),
                      );
                    default:
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 30.h),
                        child: Column(
                          children: [
                            Image.asset('assets/images/found_error.png'),
                            SizedBox(height: 2.5.h),
                            Text(
                              'Maaf, sepertinya terjadi kesalahan. Silahkan untuk mencoba kembali atau hubungi kami  jika masalah masih berlanjut.',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                      fontSize: 9.sp,
                                      fontWeight: FontWeight.w400,
                                      color: grey500),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
