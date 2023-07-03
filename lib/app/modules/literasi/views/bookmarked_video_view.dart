import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/literasi/controllers/bookmarked_video_controller.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:sizer/sizer.dart';
import 'package:youtube/youtube_thumbnail.dart';

class BookmarkedVideoView extends GetView {
  BookmarkedVideoView({Key? key}) : super(key: key);
  final c = Get.find<BookmarkedVideoController>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: c.streamBookmarked(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: buttonColor1),
          );
        }

        if (snapshot.data!.docs.isEmpty || snapshot.data == null) {
          return const Center(
            child: Text('Belum ada data bookmark'),
          );
        }
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.78.w),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var docBookmarked = snapshot.data!.docs[index];
                    Map<String, dynamic> bookmark = docBookmarked.data();
                    return GestureDetector(
                      onTap: () => Get.toNamed(
                        Routes.DETAIL_VIDEO,
                        arguments: bookmark['videoId'].toString(),
                      ),
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
                                  YoutubeThumbnail(
                                          youtubeId: bookmark['imageUrl'])
                                      .standard(),
                                  height: 8.625.h,
                                  width: 29.72.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 3.89.w),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    bookmark['title'],
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0XFF0D4136),
                                            fontSize: 9.sp),
                                  ),
                                  Text(
                                    timeago.format(
                                        DateTime.parse(bookmark['createdAt']),
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
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
