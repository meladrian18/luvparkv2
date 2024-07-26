import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParkingController extends GetxController
    with GetSingleTickerProviderStateMixin {
  ParkingController();
  RxInt currentPage = 0.obs;
  PageController pageController = PageController();
  TextEditingController searchCtrl = TextEditingController();

  void onTabTapped(int index) {
    currentPage.value = index;

    update();
  }

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    searchCtrl = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
  }
}
