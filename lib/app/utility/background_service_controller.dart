import 'dart:isolate';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:nuha/app/modules/literasi/providers/list_artikel_provider.dart';
import 'package:nuha/app/utility/notification_service_controller.dart';

final ReceivePort port = ReceivePort();

class BackgroundServiceController {
  static BackgroundServiceController? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundServiceController._internal() {
    _instance = this;
  }

  factory BackgroundServiceController() =>
      _instance ?? BackgroundServiceController._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    var getTimeNow = DateTime.now();
    // ignore: avoid_print
    print('Notifikasi artikel muncul pada: $getTimeNow');

    final NotificationServiceController notificationServiceController =
        NotificationServiceController();
    var result = await ListArtikelProvider().getListArtikel(http.Client());
    await notificationServiceController.showNotification(result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
  }

  static Future<void> cashflowCallback() async {
    var getTimeNow = DateTime.now();
    // ignore: avoid_print
    print('Notifikasi cashflow muncul pada: $getTimeNow');

    final NotificationServiceController notificationServiceController =
        NotificationServiceController();
    await notificationServiceController.showCashFlowNotification();

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
  }

  static Future<void> zakatCallback() async {
    var getTimeNow = DateTime.now();
    // ignore: avoid_print
    print('Notifikasi zakat muncul pada: $getTimeNow');

    final NotificationServiceController notificationServiceController =
        NotificationServiceController();
    await notificationServiceController.showZakatNotification();

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
  }
}
