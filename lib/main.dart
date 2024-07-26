import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luvpark_get/classes/app_color.dart';
import 'package:luvpark_get/classes/custom_body.dart';
import 'package:luvpark_get/login/index.dart';
import 'package:luvpark_get/main_controller.dart';
import 'package:luvpark_get/routes/pages.dart';
import 'package:luvpark_get/routes/routes.dart';

void main() {
  Get.put(MainController());
  Get.put(LoginScreenController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController ct = Get.find();

    return Obx(() {
      if (ct.initialRoute.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return GetPlatform.isIOS
          ? GetCupertinoApp(
              debugShowCheckedModeBanner: false,
              title: 'MyApp',
              theme: CupertinoThemeData(
                brightness: Brightness.light,
                primaryColor: AppColor.primaryColor,
                scaffoldBackgroundColor: CupertinoColors.systemBackground,
                textTheme: CupertinoTextThemeData(
                  actionTextStyle:
                      TextStyle(fontSize: 16.0, color: AppColor.primaryColor),
                ),
                barBackgroundColor: CupertinoColors.systemGrey,
              ),
              initialRoute: ct.initialRoute.value,
              getPages: AppPages.pages,
            )
          : Obx(() => GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'MyApp',
                theme: ThemeData(
                  useMaterial3: false,
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: AppColor.primaryColor,
                  ),
                  textTheme: GoogleFonts.quicksandTextTheme(),
                ),
                initialRoute:
                    ct.isLoad.value ? Routes.loading : ct.initialRoute.value,
                getPages: AppPages.pages,
              ));
    });
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      children: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
