import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:nuha/app/modules/literasi/models/list_artikel_model.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'package:nuha/app/utility/received_notification.dart';
import 'package:rxdart/subjects.dart';

final selectNotificationSubject = BehaviorSubject<String?>();
final didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

class NotificationServiceController {
  static const _channelId = "01";
  static const _channelName = "nuha_channel";
  static const _channelDesc = "Nuha Financial Channel";
  static NotificationServiceController? _instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationServiceController._internal() {
    _instance = this;
  }

  factory NotificationServiceController() =>
      _instance ?? NotificationServiceController._internal();

  Future<void> initNotifications() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {
          didReceiveLocalNotificationSubject.add(ReceivedNotification(
              id: id, title: title, body: body, payload: payload));
        });

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        final String? payload = response.payload;
        if (payload != null) {
          if (payload == 'cashflow') {
            await Get.toNamed(Routes.CASHFLOW);
          } else if (payload == 'zakat') {
            await Get.toNamed(Routes.NAVBAR);
          } else {
            await Get.toNamed(Routes.DETAIL_ARTIKEL, arguments: payload);
          }
        }
      },
    );
  }

  Future<void> showNotification(ListArtikel article) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    var randomArticle = article.data[Random().nextInt(article.data.length)];
    var titleNotification = "Rekomendasi Artikel Untuk Anda Hari Ini";
    var titleArticle = randomArticle.title;

    flutterLocalNotificationsPlugin.show(
      1,
      titleNotification,
      titleArticle,
      platformChannelSpecifics,
      payload: randomArticle.id.toString(),
    );
  }

  Future<void> showCashFlowNotification() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    var titleNotification = "Apakah anda sudah mengatur alur kas hari ini?";
    var titleArticle = 'Yuk, atur alur kas anda sekarang disini!';

    flutterLocalNotificationsPlugin.show(
      2,
      titleNotification,
      titleArticle,
      platformChannelSpecifics,
      payload: 'cashflow',
    );
  }

  Future<void> showZakatNotification() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    var titleNotification = "Awal bulan nih, udah bayar zakat belum?";
    var titleArticle = 'Yuk, bayar zakat sekarang disini!';

    flutterLocalNotificationsPlugin.show(
      3,
      titleNotification,
      titleArticle,
      platformChannelSpecifics,
      payload: 'zakat',
    );
  }
}
