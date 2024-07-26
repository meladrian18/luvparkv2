import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luvpark_get/classes/app_color.dart';
import 'package:luvpark_get/dashbarod/controller.dart';
import 'package:luvpark_get/mapa/index.dart';
import 'package:luvpark_get/settings/view.dart';
import 'package:luvpark_get/wallet/view.dart';

import '../classes/custom_body.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DashboardController ct = Get.put(DashboardController());

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
          const DashboardMapScreen(),
          const WalletScreen(),
          //  const ParkingScreen(),
          const SettingsScreen(),
        ][ct.currentPage.value],
      ),
    );
  }
}
