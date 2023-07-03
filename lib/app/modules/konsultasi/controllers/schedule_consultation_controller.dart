import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/konsultasi/models/consultant_model.dart';
import 'package:nuha/app/modules/konsultasi/models/consultation_transaction_model.dart';
import 'package:nuha/app/modules/konsultasi/models/schedule_consultation_model.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleConsultationController extends GetxController {
  String? consultantId;
  RxList<ScheduleConsultation> schedules = <ScheduleConsultation>[].obs;
  Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());
  Rx<DateTime> focusedDate = Rx<DateTime>(DateTime.now());
  Rx<TimeOfDay> selectedTime = Rx<TimeOfDay>(TimeOfDay.now());
  CalendarFormat calendarFormat = CalendarFormat.month;
  RxList<String> availableDays = <String>[].obs;
  RxList<Consultant> consultants = <Consultant>[].obs;
  Rx<DateTime> startDateTimeBooked = Rx<DateTime>(DateTime.now());
  Rx<DateTime> endDateTimeBooked = Rx<DateTime>(DateTime.now());
  RxBool isScheduleSelected = false.obs;
  String scheduleConsultationId = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  RxList<String> scheduleIds = <String>[].obs;

  ScheduleConsultationController({required this.consultantId});

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting('id', null);
    fetchAvailableDays();
    fetchSchedule(selectedDate.value);
    Future.delayed(Duration(seconds: 0)).then((_) => showConsultationInfo());
    convertToScheduleIds(schedules);
  }

  List<String> convertToScheduleIds(List<ScheduleConsultation> schedules) {
    return schedules.map((schedule) => schedule.scheduleId).toList();
  }

  String getDayName(DateTime dateTime) {
    final daysName = [
      'Minggu',
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
    ];
    return daysName[dateTime.weekday];
  }

  Future<void> fetchAvailableDays() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('consultant')
          .doc(consultantId)
          .collection('consultant_schedule')
          .get();

      final List<String> days = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return data['day'] as String;
      }).toList();
      availableDays.value = days;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchSchedule(DateTime selectedDate) async {
    final String selectedDay = getDayName(selectedDate);
    final date = selectedDate;

    print(date);
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('consultant')
          .doc(consultantId)
          .collection('consultant_schedule')
          .where('day', isEqualTo: selectedDay)
          .get();

      schedules.value = snapshot.docs
          .map((doc) => ScheduleConsultation.fromSnapshot(doc))
          .toList();
    } catch (e) {
      print(e.toString());
    }
  }

  void onDateSelected(DateTime date, DateTime focused) {
    final selectedDayName = DateFormat('EEEE', 'id_ID').format(date);

    if (availableDays.contains(selectedDayName)) {
      selectedDate.value = date;
      focusedDate.value = focused;
      fetchSchedule(date);
    }
  }

  void onCalendarFormatChanged(CalendarFormat format) {
    if (calendarFormat != format) {
      calendarFormat = format;
    }
  }

  void onCalendarPageChanged(DateTime focused) {
    focusedDate.value = focused;
  }

  int getDaysInTwoMonths(DateTime date) {
    int currentYear = date.year;
    int currentMonth = date.month;
    int nextMonth = currentMonth + 1;
    int nextYear = currentYear;

    if (nextMonth > 12) {
      nextMonth -= 12;
      nextYear++;
    }

    int daysInNextMonth = DateTime(nextYear, nextMonth + 1, 0).day;

    return (DateTime(nextYear, nextMonth, 0)
            .difference(DateTime(currentYear, currentMonth, 1))
            .inDays) +
        daysInNextMonth;
  }

  double maxRowHeight(int maxRows) {
    double dayPickerHeight = 60;
    double rowSpacing = 8;

    return (dayPickerHeight + maxRows) + (rowSpacing * (maxRows - 1));
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getConsultant(
      consultantId) async {
    return FirebaseFirestore.instance
        .collection('consultant')
        .doc(consultantId)
        .get();
  }

  TimeOfDay timeConvert(String time) {
    List<String> split = time.split(':');
    int hour = int.parse(split[0]);
    int minute = int.parse(split[1]);

    return TimeOfDay(hour: hour, minute: minute);
  }

  Future<void> getOrderData(
    String consultantId,
    String scheduleId,
    DateTime consultationStartDate,
    DateTime consultationEndDate,
  ) async {
    try {
      var data = await FirebaseFirestore.instance
          .collection('consultation_transaction')
          .where('startDateTime', isEqualTo: consultationStartDate)
          .where('endDateTime', isEqualTo: consultationEndDate)
          .get();

      if (data.docs.isEmpty) {
        ConsultationTransaction consultationTransaction =
            ConsultationTransaction(
          uid: auth.currentUser!.uid,
          consultantId: consultantId,
          scheduleId: scheduleId,
          consultationStartDate: consultationStartDate,
          consultationEndDate: consultationEndDate,
        );

        Get.toNamed(Routes.CREATE_PESANAN_KONSULTASI,
            arguments: consultationTransaction);
      } else {
        Get.bottomSheet(
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 4.w,
              vertical: 3.h,
            ),
            child: SizedBox(
              height: 43.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(child: Image.asset('assets/images/found_error.png')),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Maaf, jadwal yang kamu pilih sudah direservasi!',
                        style: Theme.of(Get.context!)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              color: grey900,
                            ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'Silahkan pilih jadwal konsultasi lainnya yang tersedia.',
                        style: Theme.of(Get.context!)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                              fontSize: 11.sp,
                              color: Colors.black,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor1,
                      ),
                      onPressed: () => Get.back(),
                      child: Text(
                        'Mengerti',
                        style: Theme.of(Get.context!)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp,
                              color: backgroundColor1,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }
    } catch (e) {
      Get.snackbar('kesalahan', '$e');
    }
  }

  void showConsultationInfo() {
    Get.bottomSheet(
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
          vertical: 3.h,
        ),
        child: SizedBox(
          height: 43.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sebelum memesan konsultasi secara online, ingat bahwa...',
                    style: Theme.of(Get.context!)
                        .textTheme
                        .headlineMedium!
                        .copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                          color: grey900,
                        ),
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Iconify(
                          Ic.round_av_timer,
                          color: buttonColor1,
                          size: 30.sp,
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Expanded(
                        flex: 9,
                        child: Text(
                          'Masuk ke meeting room tepat waktu, ya. Konsultan hanya akan menunggumu maksimal 15 menit.',
                          style: Theme.of(Get.context!)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                fontSize: 11.sp,
                                color: Colors.black,
                              ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Iconify(
                          Ri.user_unfollow_fill,
                          color: buttonColor1,
                          size: 30.sp,
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Expanded(
                        flex: 9,
                        child: Text(
                          'Kamu bisa membatalkan janji konsultasimu pada 60 menit sebelum pertemuan.',
                          style: Theme.of(Get.context!)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                fontSize: 11.sp,
                                color: Colors.black,
                              ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Iconify(
                          Bx.wallet,
                          color: buttonColor1,
                          size: 30.sp,
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Expanded(
                        flex: 9,
                        child: Text(
                          'Uangmu akan dikembalikan jika konsultan membatalkan atau tidak hadir saat konsultasi.',
                          style: Theme.of(Get.context!)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                fontSize: 11.sp,
                                color: Colors.black,
                              ),
                        ),
                      ),
                      SizedBox(height: 1.5.h),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor1,
                  ),
                  onPressed: () => Get.back(),
                  child: Text(
                    'Mengerti',
                    style:
                        Theme.of(Get.context!).textTheme.labelMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp,
                              color: backgroundColor1,
                            ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
