import 'package:get/get.dart';

class SettingsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  bool isInternetConnected = true;
  RxBool gg = false.obs;

  void onTap(bool dd) {
    gg.value = dd;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  SettingsController();
}
