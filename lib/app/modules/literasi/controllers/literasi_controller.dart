import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LiterasiController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabs;

  final List<Tab> literasiTabs = <Tab>[
    const Tab(
      text: 'Artikel',
    ),
    const Tab(
      text: 'Video',
    )
  ];

  @override
  void onInit() {
    tabs = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabs.dispose();
    super.onClose();
  }
}
