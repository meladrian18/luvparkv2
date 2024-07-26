import 'package:get/get.dart';
import 'package:luvpark_get/dashbarod/controller.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
