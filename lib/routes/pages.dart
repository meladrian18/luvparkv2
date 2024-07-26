import 'package:get/get.dart';
import 'package:luvpark_get/activate_acc/view.dart';
import 'package:luvpark_get/dashbarod/index.dart';
import 'package:luvpark_get/login/bindings.dart';
import 'package:luvpark_get/login/view.dart';
import 'package:luvpark_get/main.dart';
import 'package:luvpark_get/mapa/index.dart';
import 'package:luvpark_get/onboarding/bindings.dart';
import 'package:luvpark_get/onboarding/view.dart';
import 'package:luvpark_get/otp_screen/index.dart';
import 'package:luvpark_get/registration/index.dart';
import 'package:luvpark_get/routes/routes.dart';
import 'package:luvpark_get/terms/bindings.dart';
import 'package:luvpark_get/terms/view.dart';

import '../landing/bindings.dart';
import '../landing/view.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
        name: Routes.onboarding,
        page: () => const MyOnboardingPage(),
        binding: OnboardingBinding()),
    GetPage(
        name: Routes.landing,
        page: () => const LandingScreen(),
        binding: LandingBinding()),
    GetPage(
        name: Routes.terms,
        page: () => const TermsOfUse(),
        binding: TermsOfUseBinding()),
    GetPage(
        name: Routes.login,
        page: () => LoginScreen(),
        binding: LoginScreenBinding()),
    GetPage(
        name: Routes.dashboard,
        page: () => const DashboardScreen(),
        binding: DashboardBinding()),
    GetPage(
        name: Routes.registration,
        page: () => const RegistrationPage(),
        binding: RegistrationBinding()),
    GetPage(
      name: Routes.otp,
      page: () => const OtpScreen(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: Routes.map,
      page: () => const DashboardMapScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.loading,
      page: () => const LoadingPage(),
    ),
    GetPage(
      name: Routes.activate,
      page: () => const ActivateAccount(),
      binding: DashboardBinding(),
    ),
  ];
}
