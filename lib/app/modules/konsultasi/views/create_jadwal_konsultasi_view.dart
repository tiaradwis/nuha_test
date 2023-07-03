import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:intl/intl.dart';
import 'package:nuha/app/modules/konsultasi/controllers/schedule_consultation_controller.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:sizer/sizer.dart';

class CreateJadwalKonsultasiView
    extends GetView<ScheduleConsultationController> {
  CreateJadwalKonsultasiView({Key? key}) : super(key: key);
  final c = Get.find<ScheduleConsultationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        actions: [
          Container(
            padding: EdgeInsets.only(right: 2.98.w),
            child: IconButton(
              onPressed: () => c.showConsultationInfo(),
              icon: Iconify(
                Ion.md_information_circle_outline,
                size: 3.h,
                color: titleColor,
              ),
            ),
          ),
        ],
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(left: 4.6.w),
          child: Text(
            'Jadwal Konsultasi',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.w600, fontSize: 13.sp),
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: backgroundColor1,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        elevation: 0.5,
        toolbarHeight: 7.375.h,
      ),
      backgroundColor: backgroundColor2,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1.5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.5.w),
            child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: c.getConsultant(c.consultantId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: buttonColor1),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Column(
                      children: [
                        Card(
                          color: backgroundColor2,
                          elevation: 0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Image.network(
                                    snapshot.data!['imageUrl'],
                                    height: 8.625.h,
                                    width: 8.625.h,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(width: 3.89.w),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      snapshot.data!['name'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0XFF0D4136),
                                              fontSize: 13.sp),
                                    ),
                                    Text(
                                      snapshot.data!['category'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: grey500,
                                              fontSize: 11.sp),
                                    ),
                                    Text(
                                      NumberFormat.currency(
                                        locale: 'id',
                                        symbol: 'Rp. ',
                                      )
                                          .format(snapshot.data!['price'])
                                          .replaceAll(",00", ""),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: grey900,
                                              fontSize: 11.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Text('Data not Found');
                  }
                }
              },
            ),
          ),
          SizedBox(height: 1.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.5.w),
            child: const Divider(color: grey400),
          ),
          SizedBox(height: 1.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.5.w),
            child: Text(
              'Silahkan Pilih Waktu Konsultasi Anda',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    color: titleColor,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Obx(
              () {
                if (c.availableDays.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(top: 30.h),
                    child: Container(
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                            color: buttonColor1)),
                  );
                } else {
                  return TableCalendar(
                    headerStyle: HeaderStyle(
                      titleCentered: true,
                      titleTextStyle: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp,
                              color: titleColor),
                    ),
                    sixWeekMonthsEnforced: true,
                    calendarFormat: c.calendarFormat,
                    focusedDay: c.selectedDate.value,
                    firstDay: DateTime.now(),
                    lastDay: DateTime.now().add(
                        Duration(days: c.getDaysInTwoMonths(DateTime.now()))),
                    availableGestures: AvailableGestures.none,
                    locale: 'id_ID',
                    selectedDayPredicate: (date) {
                      return isSameDay(c.selectedDate.value, date);
                    },
                    onDaySelected: (date, focusedDay) {
                      if (!isSameDay(c.selectedDate.value, date)) {
                        c.onDateSelected(date, focusedDay);
                      }
                    },
                    onFormatChanged: (format) {
                      c.onCalendarFormatChanged(format);
                    },
                    onPageChanged: (focusedDate) {
                      c.onCalendarPageChanged(focusedDate);
                    },
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Bulan',
                    },
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, date, _) {
                        final dayName =
                            DateFormat('EEEE', 'id_ID').format(date);
                        if (!c.availableDays.contains(dayName) ||
                            date.isBefore(DateTime.now())) {
                          return Center(
                            child: Text(
                              date.day.toString(),
                              style: const TextStyle(color: Colors.grey),
                            ),
                          );
                        } else {
                          return Center(
                            child: Text(
                              date.day.toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }
                      },
                      disabledBuilder: (context, date, _) {
                        final dayName =
                            DateFormat('EEEE', 'id_ID').format(date);
                        if (!c.availableDays.contains(dayName) ||
                            date.isBefore(DateTime.now())) {
                          return Center(
                            child: Text(
                              date.day.toString(),
                              style: const TextStyle(color: Colors.grey),
                            ),
                          );
                        } else {
                          return Center(
                            child: Text(
                              date.day.toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }
                      },
                      selectedBuilder: (context, day, focusedDay) {
                        return Container(
                          width: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: buttonColor1,
                          ),
                          child: Center(
                            child: Text(
                              day.day.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                      todayBuilder: (context, day, focusedDay) {
                        return Container(
                          width: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: buttonColor1.withOpacity(0.5)),
                            color: buttonColor1.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              day.day.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150,
                      childAspectRatio: 6 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: c.schedules.length,
                  itemBuilder: (context, index) {
                    final schedules = c.schedules[index];
                    TimeOfDay timeOfDayStart =
                        c.timeConvert(schedules.startTime);
                    TimeOfDay timeOfDayEnd = c.timeConvert(schedules.endTime);
                    DateTime updateStartDateTime = DateTime(
                      c.selectedDate.value.year,
                      c.selectedDate.value.month,
                      c.selectedDate.value.day,
                      timeOfDayStart.hour,
                      timeOfDayStart.minute,
                    );
                    DateTime updateEndDateTime = DateTime(
                      c.selectedDate.value.year,
                      c.selectedDate.value.month,
                      c.selectedDate.value.day,
                      timeOfDayEnd.hour,
                      timeOfDayEnd.minute,
                    );
                    return GestureDetector(
                      onTap: () {
                        print(
                            'Tanggal & Waktu Mulai Konsultasi: ${updateStartDateTime}');
                        print(
                            'Tanggal & Waktu Selesai Konsultasi: ${updateEndDateTime}');
                        c.startDateTimeBooked.value = updateStartDateTime;
                        c.endDateTimeBooked.value = updateEndDateTime;
                        c.isScheduleSelected.value = true;
                        c.scheduleConsultationId =
                            c.schedules[index].scheduleId;
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: buttonColor1,
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          '${schedules.startTime} - ${schedules.endTime}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: backgroundColor1,
                                  fontSize: 11.sp),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: grey100,
                  width: 2,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            height: 6.5.h,
            child: Obx(
              () => c.isScheduleSelected.isTrue
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('EEEE, d MMMM yyyy, HH:mm', 'id_ID')
                              .format(c.startDateTimeBooked.value),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11.sp,
                                    color: titleColor,
                                  ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor2,
                          ),
                          onPressed: () {
                            c.getOrderData(
                              Get.arguments,
                              c.scheduleConsultationId,
                              c.startDateTimeBooked.value,
                              c.endDateTimeBooked.value,
                            );
                          },
                          child: Text(
                            'Pesan',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pilih tanggal & waktu',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11.sp,
                                    color: grey500,
                                  ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: grey400,
                          ),
                          onPressed: () {},
                          child: Text(
                            'Pesan',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: Colors.white),
                          ),
                        )
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
