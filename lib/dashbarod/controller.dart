import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luvpark_get/mapa/controller.dart';

class DashboardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  DashboardController();
  RxInt currentPage = 0.obs;
  PageController pageController = PageController();
  TextEditingController searchCtrl = TextEditingController();

  void onTabTapped(int index) {
    currentPage.value = index;
    switch (index) {
      case 0:
        Get.put(DashboardMapController());
        print("sulod sa zero");
        break;

      default:
        Get.put(DashboardMapController());
    }
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
