import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/literasi/controllers/list_artikel_controller.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'package:nuha/app/utility/result_state.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:sizer/sizer.dart';

class ListArtikelView extends GetView<ListArtikelController> {
  ListArtikelView({Key? key}) : super(key: key);
  final c = Get.find<ListArtikelController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.78.w),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Obx(
                () => ChipsChoice.single(
                  spacing: 3.3.w,
                  wrapped: true,
                  padding: EdgeInsets.symmetric(horizontal: 0.w),
                  value: c.tag.value,
                  onChanged: (val) {
                    c.tag.value = val;
                  },
                  choiceItems: const <C2Choice>[
                    C2Choice(value: 1, label: 'Semua'),
                    C2Choice(value: 2, label: 'Keuangan Syariah'),
                    C2Choice(value: 3, label: 'Tabungan Syariah'),
                  ],
                  choiceStyle: C2ChipStyle.filled(
                    foregroundStyle: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(
                            color: grey400,
                            fontWeight: FontWeight.w600,
                            fontSize: 9.sp),
                    color: grey50,
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    selectedStyle: C2ChipStyle(
                      backgroundColor: buttonColor1,
                      foregroundStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(
                              color: backgroundColor1,
                              fontWeight: FontWeight.w600,
                              fontSize: 9.sp),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 2.5.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 7.78.w),
            child: TextField(
              onTap: () => Get.toNamed(Routes.CARI_ARTIKEL),
              readOnly: true,
              cursorColor: buttonColor1,
              autocorrect: false,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w400, fontSize: 9.sp, color: grey400),
              decoration: InputDecoration(
                hintText: 'Cari artikel disini',
                hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 9.sp,
                    color: grey400),
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
                suffixIcon: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () => Get.toNamed(Routes.CARI_ARTIKEL),
                  icon: Iconify(
                    Ri.search_line,
                    size: 12.sp,
                    color: grey400,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 2.5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.78.w),
            child: Obx(
              () => FutureBuilder(
                future: (c.tag.value == 1)
                    ? c.getListArtikel()
                    : (c.tag.value == 2)
                        ? c.getListKeuanganSyariahArtikel()
                        : c.getListTabunganSyariahArtikel(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 30.h),
                      child: const CircularProgressIndicator(
                        color: buttonColor1,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Obx(
                      () {
                        switch (c.resultState.value.status) {
                          case ResultStatus.loading:
                            return Container(
                              padding: EdgeInsets.symmetric(vertical: 30.h),
                              child: const CircularProgressIndicator(
                                color: buttonColor1,
                              ),
                            );
                          case ResultStatus.hasData:
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: c.result.data.length,
                              itemBuilder: (context, index) {
                                var artikel = c.result.data[index];
                                return GestureDetector(
                                  onTap: () => Get.toNamed(
                                      Routes.DETAIL_ARTIKEL,
                                      arguments: artikel.id.toString()),
                                  child: Card(
                                    color: backgroundColor2,
                                    elevation: 0,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(18),
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
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: const Color(
                                                            0XFF0D4136),
                                                        fontSize: 9.sp),
                                              ),
                                              Text(
                                                timeago.format(
                                                    artikel.publishedAt,
                                                    locale: 'id'),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
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
                            return const Text('Data Kosong');
                          case ResultStatus.error:
                            return const Text('Error');
                          default:
                            return const SizedBox();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
