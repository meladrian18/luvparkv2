import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:luvpark_get/classes/app_color.dart';
import 'package:luvpark_get/classes/custom_body.dart';
import 'package:luvpark_get/internet/internet_conn.dart';

import 'controller.dart';

class DashboardMapScreen extends GetView<DashboardMapController> {
  const DashboardMapScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(DashboardMapController());
    final DashboardMapController ct = Get.find<DashboardMapController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ct.onInit();
    });

    return CustomScaffold(
      children: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: AppColor.bodyColor,
        child: Obx(() {
          if (!ct.netConnected.value) {
            return const InternetConn();
          } else if (ct.isLoading.value) {
            return const Center(
              child: SizedBox(
                height: 30,
                width: 40,
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (double.parse(ct.userBal[0]["amount_bal"].toString()) >=
                double.parse(ct.userBal[0]["min_wallet_bal"].toString())) {
              return accessMaps(context, ct);
            } else {
              return accessList(context, ct);
            }
          }
        }),
      ),
    );
  }

  Widget accessMaps(context, cs) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          target: LatLng(45.521563, -122.677433),
          zoom: 11.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          cs.gMapController.complete(controller);
        },
      ),
    );
  }

  Widget accessList(context, cs) {
    return StretchingOverscrollIndicator(
      axisDirection: AxisDirection.down,
      child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
          itemCount: 4,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("Title"),
              leading: Icon(Icons.car_crash),
              subtitle: Text("Subtitle"),
            );
          }),
    );
  }
}
