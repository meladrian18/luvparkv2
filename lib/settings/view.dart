import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luvpark_get/classes/app_color.dart';
import 'package:luvpark_get/classes/custom_body.dart';
import 'package:luvpark_get/classes/custom_button.dart';
import 'package:luvpark_get/classes/custom_text.dart';
import 'package:luvpark_get/classes/vertical_height.dart';
import 'package:luvpark_get/routes/routes.dart';
import 'package:luvpark_get/settings/controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final SettingsController ct = Get.put(SettingsController());

    return CustomScaffold(
      children: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 15, 0),
        child: StretchingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image(
                        image: AssetImage("assets/images/otp_logo.png"),
                        fit: BoxFit.contain,
                        width: 200,
                        height: 200,
                      ),
                    ),
                    Center(
                      child: CustomTitle(
                        text: "Settings Screen",
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                Container(height: 20),
                const VerticalHeight(height: 30),
                CustomButton(
                  loading: false,
                  text: "Verify",
                  onPressed: () {
                    ct.onTap(!ct.gg.value);
                  },
                ),
                Container(
                  height: 20,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account? ",
                          style: GoogleFonts.manrope(
                            fontSize: 14,
                            color: AppColor.linkLabel,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: " Register",
                          style: GoogleFonts.manrope(
                            fontSize: 14,
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              Get.toNamed(Routes.landing);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
