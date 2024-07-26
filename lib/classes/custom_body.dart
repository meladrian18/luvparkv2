import 'package:flutter/material.dart';
import 'package:luvpark_get/classes/app_color.dart';

class CustomScaffold extends StatelessWidget {
  final Widget children;
  final AppBar? appBar;
  final Color? bodyColor;
  final Widget? bottomNavigationBar;
  const CustomScaffold(
      {super.key,
      required this.children,
      this.appBar,
      this.bodyColor,
      this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.scafColor,
      appBar: appBar,
      body: SafeArea(
        child: Container(
          color: bodyColor ?? AppColor.bodyColor,
          child: children,
        ),
      ),
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: bottomNavigationBar ?? bottomNavigationBar,
    );
  }
}
