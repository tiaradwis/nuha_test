import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/gridicons.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:intl/intl.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/literasi/controllers/bookmark_video_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/detail_video_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/komentar_video_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/recommended_video_controller.dart';
import 'package:nuha/app/modules/literasi/models/balasan_komentar_video_model.dart';
import 'package:nuha/app/modules/literasi/models/komentar_video_model.dart';
import 'package:nuha/app/utility/result_state.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';
import 'package:youtube/youtube_thumbnail.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:timeago/timeago.dart' as timeago;

class DetailVideoView extends GetView<DetailVideoController> {
  DetailVideoView({Key? key}) : super(key: key);
  final c = Get.find<DetailVideoController>();
  final komentarC = Get.find<KomentarVideoController>();
  final bookmarkC = Get.find<BookmarkVideoController>();
  final recommendedC = Get.find<RecommendedVideoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<dynamic>(
        future: c.fetchDetailVideo(Get.arguments),
        builder: (context, snapshot) {
          return Obx(
            () {
              switch (c.resultState.value.status) {
                case ResultStatus.loading:
                  return const Center(
                    child: CircularProgressIndicator(
                      color: buttonColor1,
                    ),
                  );
                case ResultStatus.hasData:
                  var detail = c.resultDetailVideo.data;
                  final youtubeC = YoutubePlayerController(
                    initialVideoId: detail.video.length == 28
                        ? detail.video.substring(17)
                        : detail.video.substring(32),
                    flags: const YoutubePlayerFlags(
                      autoPlay: true,
                      mute: false,
                      controlsVisibleAtStart: true,
                      enableCaption: true,
                      useHybridComposition: true,
                    ),
                  );
                  return YoutubePlayerBuilder(
                    onExitFullScreen: () {
                      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                          overlays: [
                            SystemUiOverlay.top,
                          ]);
                    },
                    player: YoutubePlayer(
                      controller: youtubeC,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: buttonColor1,
                      progressColors: const ProgressBarColors(
                        playedColor: buttonColor1,
                        handleColor: buttonColor1,
                      ),
                      topActions: <Widget>[
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            youtubeC.metadata.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                      bottomActions: [
                        CurrentPosition(),
                        ProgressBar(
                          isExpanded: true,
                          colors: const ProgressBarColors(
                            playedColor: buttonColor1,
                            handleColor: buttonColor1,
                          ),
                        ),
                        RemainingDuration(),
                        FullScreenButton(),
                      ],
                    ),
                    builder: (context, player) => Scaffold(
                      resizeToAvoidBottomInset: true,
                      backgroundColor: backgroundColor1,
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
                          'Video',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 13.sp),
                        ),
                        actions: [
                          Container(
                            padding: EdgeInsets.only(right: 2.98.w),
                            child: Obx(
                              () => IconButton(
                                onPressed: () => bookmarkC.toggleBookmark(
                                  detail.id.toString(),
                                  detail.title,
                                  detail.video.length == 28
                                      ? detail.video.substring(17)
                                      : detail.video.substring(32),
                                ),
                                icon: Iconify(
                                  bookmarkC.isBookmarked.value
                                      ? MaterialSymbols.bookmark
                                      : MaterialSymbols.bookmark_outline,
                                  size: 3.h,
                                  color: titleColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                        systemOverlayStyle: const SystemUiOverlayStyle(
                          statusBarColor: backgroundColor1,
                          statusBarIconBrightness: Brightness.dark,
                          statusBarBrightness: Brightness.light,
                        ),
                        elevation: 0.7,
                        toolbarHeight: 7.375.h,
                      ),
                      body: Column(
                        children: [
                          player,
                          Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              children: [
                                SizedBox(height: 2.5.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.2.w),
                                  child: GradientText(
                                    detail.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 21.sp),
                                    colors: const [buttonColor1, buttonColor2],
                                  ),
                                ),
                                SizedBox(height: 0.5.h),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.2.w),
                                  child: Text(
                                    DateFormat('dd MMMM yyyy, HH:mm')
                                        .format(detail.publishedAt),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 9.sp,
                                            color: grey500),
                                  ),
                                ),
                                SizedBox(height: 2.5.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.2.w),
                                  child: Text(
                                    'Deskripsi',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: grey500,
                                          fontSize: 13.sp,
                                        ),
                                  ),
                                ),
                                SizedBox(height: 0.5.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.2.w),
                                  child: Text(
                                    detail.description,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: grey500,
                                          fontSize: 11.sp,
                                        ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                SizedBox(height: 2.5.h),
                                GestureDetector(
                                  onTap: () {
                                    customBottomSheet(context);
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: grey50,
                                    ),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 12.2.w),
                                    child: Padding(
                                      padding: EdgeInsets.all(1.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          StreamBuilder<List<KomentarVideo>>(
                                            stream: komentarC.loadComments(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                final comments = snapshot.data!;
                                                if (comments.isEmpty) {
                                                  return Row(
                                                    children: [
                                                      Text(
                                                        'Komentar',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelLarge!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13.sp,
                                                              color: titleColor,
                                                            ),
                                                      ),
                                                      SizedBox(width: 1.5.w),
                                                      Text(
                                                        '0',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                              fontSize: 13.sp,
                                                              color: titleColor,
                                                            ),
                                                      ),
                                                    ],
                                                  );
                                                } else {
                                                  return Row(
                                                    children: [
                                                      Text(
                                                        'Komentar',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelLarge!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13.sp,
                                                              color: titleColor,
                                                            ),
                                                      ),
                                                      SizedBox(width: 1.5.w),
                                                      Text(
                                                        comments.length
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                              fontSize: 13.sp,
                                                              color: titleColor,
                                                            ),
                                                      ),
                                                    ],
                                                  );
                                                }
                                              } else if (snapshot.hasError) {
                                                return const Center(
                                                  child:
                                                      Text('Terjadi Kesalahan'),
                                                );
                                              } else {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: buttonColor1),
                                                );
                                              }
                                            },
                                          ),
                                          SizedBox(
                                            height: 7.5.h,
                                            child: StreamBuilder<
                                                List<KomentarVideo>>(
                                              stream: komentarC.loadComments(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  final comments =
                                                      snapshot.data!;
                                                  if (comments.isEmpty) {
                                                    return Center(
                                                      child: Text(
                                                        'Belum ada komentar',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                fontSize: 11.sp,
                                                                color: grey500),
                                                      ),
                                                    );
                                                  } else {
                                                    return ListView.builder(
                                                      physics:
                                                          const BouncingScrollPhysics(),
                                                      itemCount: 1,
                                                      itemBuilder:
                                                          (context, index) {
                                                        if (komentarC
                                                            .comments.isEmpty) {
                                                          return Center(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 2.5
                                                                          .h),
                                                              child: Text(
                                                                'Belum ada komentar',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                        fontSize: 11
                                                                            .sp,
                                                                        color:
                                                                            grey500),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        final comment =
                                                            komentarC.comments[
                                                                index];
                                                        return Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 1.h),
                                                          child: ListTile(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .all(0),
                                                            leading: SizedBox(
                                                              height: 45,
                                                              width: 45,
                                                              child: CircleAvatar(
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                          comment
                                                                              .imageURL)),
                                                            ),
                                                            title: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  comment
                                                                      .descKomentar,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .copyWith(
                                                                          fontSize:
                                                                              11.sp),
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  }
                                                } else if (snapshot.hasError) {
                                                  return const Center(
                                                    child: Text(
                                                        'Terjadi Kesalahan'),
                                                  );
                                                } else {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                            color:
                                                                buttonColor1),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2.5.h),
                                // Container(
                                //   padding:
                                //       EdgeInsets.symmetric(horizontal: 12.2.w),
                                //   child: GradientText(
                                //     'Video Terkait',
                                //     style: Theme.of(context)
                                //         .textTheme
                                //         .labelMedium!
                                //         .copyWith(
                                //             fontWeight: FontWeight.w600,
                                //             fontSize: 17.sp),
                                //     colors: const [buttonColor1, buttonColor2],
                                //   ),
                                // ),
                                // SizedBox(height: 1.5.h),
                                // Container(
                                //   padding:
                                //       EdgeInsets.symmetric(horizontal: 12.2.w),
                                //   child: Obx(
                                //     () {
                                //       switch (recommendedC
                                //           .resultState.value.status) {
                                //         case ResultStatus.loading:
                                //           return Container(
                                //             padding: EdgeInsets.symmetric(
                                //                 vertical: 30.h),
                                //             child:
                                //                 const CircularProgressIndicator(
                                //               color: buttonColor1,
                                //             ),
                                //           );
                                //         case ResultStatus.hasData:
                                //           return ListView.separated(
                                //             shrinkWrap: true,
                                //             physics:
                                //                 const NeverScrollableScrollPhysics(),
                                //             itemCount:
                                //                 recommendedC.result.data.length,
                                //             itemBuilder: (context, index) {
                                //               var recommended = recommendedC
                                //                   .result.data[index];
                                //               return GestureDetector(
                                //                 onTap: () {},
                                //                 child: Card(
                                //                   color: backgroundColor1,
                                //                   elevation: 0,
                                //                   child: Row(
                                //                     crossAxisAlignment:
                                //                         CrossAxisAlignment
                                //                             .start,
                                //                     children: [
                                //                       Flexible(
                                //                         child: ClipRRect(
                                //                           borderRadius:
                                //                               BorderRadius
                                //                                   .circular(18),
                                //                           child: Image.network(
                                //                             YoutubeThumbnail(
                                //                               youtubeId: recommended
                                //                                           .video
                                //                                           .length ==
                                //                                       28
                                //                                   ? recommended
                                //                                       .video
                                //                                       .substring(
                                //                                           17)
                                //                                   : recommended
                                //                                       .video
                                //                                       .substring(
                                //                                           32),
                                //                             ).standard(),
                                //                             height: 8.625.h,
                                //                             width: 29.72.w,
                                //                             fit: BoxFit.cover,
                                //                             errorBuilder:
                                //                                 (context,
                                //                                     exception,
                                //                                     stackTrace) {
                                //                               return Container(
                                //                                 height: 8.625.h,
                                //                                 width: 29.72.w,
                                //                                 color:
                                //                                     Colors.grey,
                                //                                 child: const Icon(
                                //                                     Icons
                                //                                         .error),
                                //                               );
                                //                             },
                                //                           ),
                                //                         ),
                                //                       ),
                                //                       SizedBox(width: 3.89.w),
                                //                       Expanded(
                                //                         child: Column(
                                //                           mainAxisAlignment:
                                //                               MainAxisAlignment
                                //                                   .start,
                                //                           crossAxisAlignment:
                                //                               CrossAxisAlignment
                                //                                   .start,
                                //                           mainAxisSize:
                                //                               MainAxisSize.max,
                                //                           children: [
                                //                             Text(
                                //                               recommended.title,
                                //                               maxLines: 3,
                                //                               overflow:
                                //                                   TextOverflow
                                //                                       .ellipsis,
                                //                               style: Theme.of(
                                //                                       context)
                                //                                   .textTheme
                                //                                   .bodySmall!
                                //                                   .copyWith(
                                //                                       fontWeight:
                                //                                           FontWeight
                                //                                               .w600,
                                //                                       color: const Color(
                                //                                           0XFF0D4136),
                                //                                       fontSize:
                                //                                           9.sp),
                                //                             ),
                                //                             Text(
                                //                               timeago.format(
                                //                                   recommended
                                //                                       .publishedAt,
                                //                                   locale: 'id'),
                                //                               maxLines: 1,
                                //                               overflow:
                                //                                   TextOverflow
                                //                                       .ellipsis,
                                //                               style: Theme.of(
                                //                                       context)
                                //                                   .textTheme
                                //                                   .bodySmall!
                                //                                   .copyWith(
                                //                                       fontWeight:
                                //                                           FontWeight
                                //                                               .w400,
                                //                                       color:
                                //                                           grey500,
                                //                                       fontSize:
                                //                                           8.sp),
                                //                             ),
                                //                           ],
                                //                         ),
                                //                       ),
                                //                     ],
                                //                   ),
                                //                 ),
                                //               );
                                //             },
                                //             separatorBuilder: (context, index) {
                                //               return Divider(
                                //                 color: grey50,
                                //                 thickness: 0.2.h,
                                //               );
                                //             },
                                //           );
                                //         case ResultStatus.noData:
                                //           return const Text('Data Kosong');
                                //         case ResultStatus.error:
                                //           return const Text('Error');
                                //         default:
                                //           return const SizedBox();
                                //       }
                                //     },
                                //   ),
                                // ),
                                SizedBox(height: 1.h),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                case ResultStatus.noData:
                  return const Text('Data Kosong');
                case ResultStatus.error:
                  return Text(c.message);
                default:
                  return const SizedBox();
              }
            },
          );
        },
      ),
    );
  }

  void customBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      useSafeArea: true,
      builder: (BuildContext context) {
        return AnimationConfiguration.synchronized(
          duration: const Duration(milliseconds: 500),
          child: SlideAnimation(
            verticalOffset: 100.0,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 1.h, left: 3.5.w, right: 0.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Komentar',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.sp,
                                  color: titleColor),
                        ),
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: Iconify(
                            Gridicons.cross,
                            color: titleColor,
                            size: 17.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h),
                  const Divider(color: grey100, thickness: 1, height: 0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.5.w),
                    child: SizedBox(
                      height: 55.h,
                      child: StreamBuilder<List<KomentarVideo>>(
                        stream: komentarC.loadComments(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final comments = snapshot.data!;
                            if (comments.isEmpty) {
                              return Center(
                                child: Text('Belum ada komentar',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontSize: 11.sp, color: grey500)),
                              );
                            } else {
                              return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: comments.length,
                                itemBuilder: (context, index) {
                                  final comment = comments[index];
                                  return Padding(
                                    padding: EdgeInsets.only(top: 1.h),
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.all(0),
                                      leading: SizedBox(
                                        height: 45, // Tinggi yang diinginkan
                                        width: 45,
                                        child: CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(comment.imageURL)),
                                      ),
                                      title: Row(
                                        children: [
                                          SizedBox(height: 1.h),
                                          Text(
                                            comment.name.substring(0,
                                                min(comment.name.length, 21)),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: grey400,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10.sp),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(width: 0.75.h),
                                          Text(
                                            '.',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: grey400,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 10.sp),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(width: 0.75.h),
                                          Text(
                                            timeago.format(comment.createdAt,
                                                locale: 'id'),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: grey400,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10.sp),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            comment.descKomentar,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(fontSize: 11.sp),
                                          ),
                                          SizedBox(height: 1.5.h),
                                          SizedBox(
                                            height: 11.sp,
                                            width: 11.sp,
                                            child: IconButton(
                                              splashRadius: 13.sp,
                                              padding: EdgeInsets.zero,
                                              constraints:
                                                  const BoxConstraints(),
                                              onPressed: () {
                                                showReplyComment(context,
                                                    comment.idKomentar);
                                              },
                                              icon: Iconify(
                                                Mdi.message_reply_text,
                                                size: 11.sp,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 1.5.h),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text('Terjadi Kesalahan'),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  const Divider(color: grey100, thickness: 1, height: 0),
                  Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 0.3.h),
                      child: Padding(
                        padding: EdgeInsets.all(1.h),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              FutureBuilder<Map<String, dynamic>?>(
                                future: komentarC.getProfile(),
                                builder: (context, snapshot) {
                                  if (snapshot.data == null) {
                                    return const SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                          color: buttonColor1),
                                    );
                                  } else {
                                    return snapshot.data!["profile"] != null
                                        ? SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  snapshot.data!["profile"]),
                                            ),
                                          )
                                        : SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                "https://ui-avatars.com/api/?name=${snapshot.data!["name"]}",
                                              ),
                                            ),
                                          );
                                  }
                                },
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              SizedBox(
                                width: 84.5.w,
                                child: TextField(
                                  onTap: () {
                                    commentTextField(context);
                                  },
                                  readOnly: true,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 9.sp,
                                          color: grey900),
                                  decoration: InputDecoration(
                                    hintText: 'Tambahkan komentar...',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 9.sp,
                                            color: grey400),
                                    border: const OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 1.5.h, horizontal: 1.5.h),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 0, color: grey50),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 0, color: grey50),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    isDense: true,
                                    filled: true,
                                    fillColor: grey50,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void commentTextField(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AnimationConfiguration.synchronized(
          duration: const Duration(milliseconds: 250),
          child: FadeInAnimation(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 0.3.h),
                        child: Padding(
                          padding: EdgeInsets.all(1.h),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                FutureBuilder<Map<String, dynamic>?>(
                                  future: komentarC.getProfile(),
                                  builder: (context, snapshot) {
                                    if (snapshot.data == null) {
                                      return const SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator(
                                            color: buttonColor1),
                                      );
                                    } else {
                                      return snapshot.data!["profile"] != null
                                          ? SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    snapshot.data!["profile"]),
                                              ),
                                            )
                                          : SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                  "https://ui-avatars.com/api/?name=${snapshot.data!["name"]}",
                                                ),
                                              ),
                                            );
                                    }
                                  },
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                SizedBox(
                                  width: 77.w,
                                  child: TextField(
                                    autofocus: true,
                                    controller: komentarC.descC,
                                    cursorColor: buttonColor1,
                                    autocorrect: false,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 9.sp,
                                            color: grey900),
                                    decoration: InputDecoration(
                                      hintText: 'Tambahkan komentar...',
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 9.sp,
                                              color: grey400),
                                      border: const OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 1.5.h, horizontal: 1.5.h),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 0, color: grey50),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 0, color: grey50),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      isDense: true,
                                      filled: true,
                                      fillColor: grey50,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                IconButton(
                                  splashRadius: 13.sp,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: () {
                                    komentarC.addComment(komentarC.descC.text);
                                    komentarC.descC.clear();
                                    Get.back();
                                  },
                                  icon: const Iconify(
                                    MaterialSymbols.send_outline,
                                    color: buttonColor1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void showReplyComment(BuildContext context, String idKomentar) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      useSafeArea: true,
      builder: (BuildContext context) {
        return AnimationConfiguration.synchronized(
          duration: const Duration(milliseconds: 500),
          child: SlideAnimation(
            horizontalOffset: -300,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 1.h, left: 3.5.w, right: 0.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Iconify(
                            Mdi.arrow_left,
                            color: titleColor,
                            size: 17.sp,
                          ),
                        ),
                        Text(
                          'Balasan',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.sp,
                                  color: titleColor),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.back();
                            Get.back();
                          },
                          icon: Iconify(
                            Gridicons.cross,
                            color: titleColor,
                            size: 17.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h),
                  const Divider(color: grey100, thickness: 1, height: 0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.5.w),
                    child: SizedBox(
                      height: 55.h,
                      child: StreamBuilder<List<ReplyVideo>>(
                        stream: komentarC.loadReplyComments(idKomentar),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final replys = snapshot.data!;
                            if (replys.isEmpty) {
                              return Center(
                                child: Text('Tidak ada balasan komentar',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontSize: 11.sp, color: grey500)),
                              );
                            } else {
                              return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: replys.length,
                                itemBuilder: (context, index) {
                                  final reply = replys[index];
                                  return Padding(
                                    padding: EdgeInsets.only(top: 1.h),
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.all(0),
                                      leading: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(reply.imageURL)),
                                      title: Row(
                                        children: [
                                          SizedBox(height: 1.h),
                                          Text(
                                            reply.name.substring(
                                                0, min(reply.name.length, 21)),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: grey400,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10.sp),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(width: 0.75.h),
                                          Text(
                                            '.',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: grey400,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 10.sp),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(width: 0.75.h),
                                          Text(
                                            timeago.format(reply.createdAt,
                                                locale: 'id'),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: grey400,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10.sp),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            reply.descBalasan,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(fontSize: 11.sp),
                                          ),
                                          SizedBox(height: 1.5.h),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text('Terjadi Kesalahan'),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                  color: buttonColor1),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  const Divider(color: grey100, thickness: 1, height: 0),
                  Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 0.3.h),
                      child: Padding(
                        padding: EdgeInsets.all(1.h),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              FutureBuilder<Map<String, dynamic>?>(
                                future: komentarC.getProfile(),
                                builder: (context, snapshot) {
                                  if (snapshot.data == null) {
                                    return const SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                          color: buttonColor1),
                                    );
                                  } else {
                                    return snapshot.data!["profile"] != null
                                        ? SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  snapshot.data!["profile"]),
                                            ),
                                          )
                                        : SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                "https://ui-avatars.com/api/?name=${snapshot.data!["name"]}",
                                              ),
                                            ),
                                          );
                                  }
                                },
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              SizedBox(
                                width: 86.w,
                                child: TextField(
                                  onTap: () {
                                    replyTextFIeld(context, idKomentar);
                                  },
                                  readOnly: true,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 9.sp,
                                          color: grey900),
                                  decoration: InputDecoration(
                                    hintText: 'Tambahkan balasan...',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 9.sp,
                                            color: grey400),
                                    border: const OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 1.5.h, horizontal: 1.5.h),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 0, color: grey50),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 0, color: grey50),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    isDense: true,
                                    filled: true,
                                    fillColor: grey50,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void replyTextFIeld(BuildContext context, String idKomentar) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AnimationConfiguration.synchronized(
          duration: const Duration(milliseconds: 250),
          child: FadeInAnimation(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 0.3.h),
                        child: Padding(
                          padding: EdgeInsets.all(1.h),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                FutureBuilder<Map<String, dynamic>?>(
                                  future: komentarC.getProfile(),
                                  builder: (context, snapshot) {
                                    if (snapshot.data == null) {
                                      return const SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator(
                                            color: buttonColor1),
                                      );
                                    } else {
                                      return snapshot.data!["profile"] != null
                                          ? SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    snapshot.data!["profile"]),
                                              ),
                                            )
                                          : SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                  "https://ui-avatars.com/api/?name=${snapshot.data!["name"]}",
                                                ),
                                              ),
                                            );
                                    }
                                  },
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                SizedBox(
                                  width: 77.w,
                                  child: TextField(
                                    autofocus: true,
                                    controller: komentarC.replyDescC,
                                    cursorColor: buttonColor1,
                                    autocorrect: false,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 9.sp,
                                            color: grey900),
                                    decoration: InputDecoration(
                                      hintText: 'Tambahkan balasan...',
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 9.sp,
                                              color: grey400),
                                      border: const OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 1.5.h, horizontal: 1.5.h),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 0, color: grey50),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 0, color: grey50),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      isDense: true,
                                      filled: true,
                                      fillColor: grey50,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                IconButton(
                                  splashRadius: 13.sp,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: () {
                                    komentarC.addReplyComment(
                                        idKomentar, komentarC.replyDescC.text);
                                    komentarC.replyDescC.clear();
                                    Get.back();
                                  },
                                  icon: const Iconify(
                                    MaterialSymbols.send_outline,
                                    color: buttonColor1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
