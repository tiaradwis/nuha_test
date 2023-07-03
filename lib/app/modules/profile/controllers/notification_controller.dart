import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:nuha/app/utility/background_service_controller.dart';
import 'package:nuha/app/utility/notification_service_controller.dart';
import 'package:nuha/main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationController extends GetxController {
  RxBool isLiterasiOn = false.obs;
  RxBool isCashFlowOn = false.obs;
  RxBool isZakatOn = false.obs;

  final NotificationServiceController notificationServiceController =
      NotificationServiceController();

  Future<void> scheduleLiterationNotification(bool value) async {
    isLiterasiOn.value = value;

    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    tz.TZDateTime currentDateTime = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDateTime = tz.TZDateTime(
      tz.local,
      currentDateTime.year,
      currentDateTime.month,
      currentDateTime.day,
      9,
      0,
      0,
    );

    if (currentDateTime.isAfter(scheduledDateTime)) {
      scheduledDateTime = scheduledDateTime.add(const Duration(days: 1));
    }

    if (isLiterasiOn.value) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;

      if (granted == true) {
        // ignore: avoid_print
        print('Notifikasi artikel aktif pada : $scheduledDateTime');
        await AndroidAlarmManager.periodic(
          const Duration(hours: 24),
          1,
          BackgroundServiceController.callback,
          startAt: scheduledDateTime,
          exact: true,
          wakeup: true,
          rescheduleOnReboot: true,
          allowWhileIdle: true,
        );
      } else {
        var status = await Permission.notification.status;
        if (status.isDenied) {
          var isRequested = await Permission.notification.request().isGranted;
          if (!isRequested) {
            await openAppSettings();
          }
        } else if (status.isPermanentlyDenied) {
          await openAppSettings();
        }

        isLiterasiOn.value = false;
      }
    } else {
      var getTimeNow = DateTime.now();
      // ignore: avoid_print
      print('Notifikasi artikel non-aktif pada : $getTimeNow');
      await AndroidAlarmManager.cancel(1);
    }

    await toggleLiterasiNotification(isLiterasiOn.value);
  }

  Future<void> scheduleCashflowNotification(bool value) async {
    isCashFlowOn.value = value;

    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    tz.TZDateTime currentDateTime = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDateTime = tz.TZDateTime(
      tz.local,
      currentDateTime.year,
      currentDateTime.month,
      currentDateTime.day,
      20,
      0,
      0,
    );

    if (currentDateTime.isAfter(scheduledDateTime)) {
      scheduledDateTime = scheduledDateTime.add(const Duration(days: 1));
    }

    if (isCashFlowOn.value) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;

      if (granted == true) {
        // ignore: avoid_print
        print('Notifikasi cashflow aktif pada : $scheduledDateTime');
        await AndroidAlarmManager.periodic(
          const Duration(hours: 24),
          2,
          BackgroundServiceController.cashflowCallback,
          startAt: scheduledDateTime,
          exact: true,
          wakeup: true,
          rescheduleOnReboot: true,
          allowWhileIdle: true,
        );
      } else {
        var status = await Permission.notification.status;
        if (status.isDenied) {
          var isRequested = await Permission.notification.request().isGranted;
          if (!isRequested) {
            await openAppSettings();
          }
        } else if (status.isPermanentlyDenied) {
          await openAppSettings();
        }

        isCashFlowOn.value = false;
      }
    } else {
      var getTimeNow = DateTime.now();
      // ignore: avoid_print
      print('Notifikasi cashflow non-aktif pada : $getTimeNow');
      await AndroidAlarmManager.cancel(2);
    }

    await toggleCashflowNotification(isCashFlowOn.value);
  }

  Future<void> scheduleZakatNotification(bool value) async {
    isZakatOn.value = value;

    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
    int getNextMonthTotalDays = getTotalDaysInNextMonth();

    tz.TZDateTime currentDateTime = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDateTime = tz.TZDateTime(
      tz.local,
      currentDateTime.year,
      currentDateTime.month + 1,
      1,
      13,
      0,
      0,
    );

    if (currentDateTime.isAfter(scheduledDateTime)) {
      scheduledDateTime = scheduledDateTime.add(const Duration(days: 1));
    }

    if (isZakatOn.value) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;

      if (granted == true) {
        // ignore: avoid_print
        print('Notifikasi zakat aktif pada : $scheduledDateTime');

        await AndroidAlarmManager.periodic(
          Duration(days: getNextMonthTotalDays),
          3,
          BackgroundServiceController.zakatCallback,
          startAt: scheduledDateTime,
          exact: true,
          wakeup: true,
          rescheduleOnReboot: true,
          allowWhileIdle: true,
        );
      } else {
        var status = await Permission.notification.status;
        if (status.isDenied) {
          var isRequested = await Permission.notification.request().isGranted;
          if (!isRequested) {
            await openAppSettings();
          }
        } else if (status.isPermanentlyDenied) {
          await openAppSettings();
        }

        isZakatOn.value = false;
      }
    } else {
      var getTimeNow = DateTime.now();
      // ignore: avoid_print
      print('Notifikasi zakat non-aktif pada : $getTimeNow');
      await AndroidAlarmManager.cancel(3);
    }

    await toggleZakatNotification(isZakatOn.value);
  }

  Future<void> toggleLiterasiNotification(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('literasiEnable', value);
    isLiterasiOn.value = value;
  }

  Future<void> toggleCashflowNotification(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('cashflowEnable', value);
    isCashFlowOn.value = value;
  }

  Future<void> toggleZakatNotification(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('zakatEnable', value);
    isZakatOn.value = value;
  }

  Future<void> loadAllNotificationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final literasiEnable = prefs.getBool('literasiEnable') ?? false;
    final cashflowEnable = prefs.getBool('cashflowEnable') ?? false;
    final zakatEnable = prefs.getBool('zakatEnable') ?? false;

    isLiterasiOn.value = literasiEnable;
    isCashFlowOn.value = cashflowEnable;
    isZakatOn.value = zakatEnable;

    await scheduleLiterationNotification(literasiEnable);
    await scheduleCashflowNotification(cashflowEnable);
    await scheduleZakatNotification(zakatEnable);
  }

  int getTotalDaysInNextMonth() {
    tz.initializeTimeZones();

    // Mendapatkan zona waktu lokal
    tz.Location localZone = tz.local;
    // Mendapatkan tanggal saat ini dalam zona waktu lokal
    tz.TZDateTime currentDate = tz.TZDateTime.now(localZone);

    // Mendapatkan tanggal bulan depan dalam zona waktu lokal
    tz.TZDateTime nextMonthDate =
        tz.TZDateTime(localZone, currentDate.year, currentDate.month + 1);

    // Menghitung tanggal pertama bulan depan
    tz.TZDateTime nextMonthFirstDay =
        tz.TZDateTime(localZone, nextMonthDate.year, nextMonthDate.month);

    // Menghitung tanggal terakhir bulan depan
    tz.TZDateTime nextMonthLastDay =
        tz.TZDateTime(localZone, nextMonthDate.year, nextMonthDate.month + 1);
    nextMonthLastDay = nextMonthLastDay.subtract(const Duration(days: 1));

    // Menghitung selisih hari untuk mendapatkan total hari di bulan depan
    Duration difference = nextMonthLastDay.difference(nextMonthFirstDay);
    int totalDaysInNextMonth = difference.inDays + 1;

    return totalDaysInNextMonth;
  }
}
