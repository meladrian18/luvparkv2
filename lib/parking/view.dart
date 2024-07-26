import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luvpark_get/classes/app_color.dart';
import 'package:luvpark_get/settings/view.dart';
import 'package:luvpark_get/wallet/view.dart';

import '../classes/custom_body.dart';
import 'controller.dart';

class ParkingScreen extends StatelessWidget {
  const ParkingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ParkingController ct = Get.put(ParkingController());

    return CustomScaffold(
      bodyColor: AppColor.primaryColor,
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: ct.currentPage.value,
          selectedLabelStyle: GoogleFonts.manrope(
            fontSize: 12,
            color: Colors.black,
          ),
          unselectedLabelStyle: GoogleFonts.manrope(
            fontSize: 12,
            color: Colors.black,
          ),
          onTap: (d) {
            ct.onTabTapped(d);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wallet, color: Colors.black),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_parking, color: Colors.black),
              label: 'Parking',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
      children: Obx(
        () => [
          const ParkingScreen(),
          const WalletScreen(),
          const ParkingScreen(),
          const SettingsScreen(),
        ][ct.currentPage.value],
      ),
    );
  }
}
