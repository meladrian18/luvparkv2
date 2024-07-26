import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:luvpark_get/functions/functions.dart';

class DashboardMapController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Completer<GoogleMapController> gMapController = Completer();
  RxBool netConnected = false.obs;
  RxBool isLoading = true.obs;
  DashboardMapController();
  RxList userBal = [].obs;

  void onTap(bool dd) {
    netConnected.value = dd;
  }

  @override
  void onInit() {
    super.onInit();
    gMapController = Completer();
    getUserData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getUserData() {
    isLoading.value = true;

    Functions.getUserBalance(Get.context!, (dataBalance) {
      userBal.value = [];
      if (!dataBalance[0]["has_net"]) {
        isLoading.value = false;
        netConnected.value = false;
      } else {
        netConnected.value = true;
        isLoading.value = false;
        userBal.addAll(dataBalance[0]["items"]);
      }
      update();
    });
  }
}
