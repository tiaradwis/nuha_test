import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavbarController extends GetxController {
  late PageController pageController;

  RxInt currentPage = 0.obs;

  void goToTab(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  final persistentController = PersistentTabController(initialIndex: 0);

  final _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;

  void updateIndex(int index) {
    _currentIndex.value = index;
  }
}
