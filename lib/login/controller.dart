import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luvpark_get/auth/authentication.dart';
import 'package:luvpark_get/classes/alert_dialog.dart';
import 'package:luvpark_get/http/api_keys.dart';
import 'package:luvpark_get/http/http_request.dart';

class LoginScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  LoginScreenController();
  RxBool isAgree = false.obs;
  RxBool isShowPass = false.obs;
  RxBool isLoading = false.obs;

  TextEditingController mobileNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLogin = false;
  bool isInternetConnected = true;

  bool isTappedReg = false;
  var usersLogin = [];

  void toggleLoading(bool value) {
    isLoading.value = value;
  }

  void onPageChanged(bool agree) {
    isAgree.value = agree;
    update();
  }

  void visibilityChanged(bool visible) {
    isShowPass.value = visible;
    update();
  }

  Future<void> getAccountStatus(context, mobile, Function cb) async {
    print("mobile $mobile");
    String apiParam =
        "${ApiKeys.gApiSubFolderGetLoginAttemptRecord}?mobile_no=$mobile";
    print("apiParam $apiParam");
    HttpRequest(api: apiParam).get().then((objData) {
      if (objData == "No Internet") {
        CustomDialog().internetErrorDialog(context, () {
          Get.back();
          cb([
            {"has_net": false, "items": []}
          ]);
        });
        return;
      }
      if (objData == null) {
        CustomDialog().errorDialog(context, "Error",
            "Error while connecting to server, Please try again.", () {
          Get.back();
          cb([
            {"has_net": true, "items": []}
          ]);
        });

        return;
      }
      if (objData["items"].isEmpty) {
        CustomDialog().errorDialog(context, "Error", "Invalid account.", () {
          Get.back();
          cb([
            {"has_net": true, "items": []}
          ]);
        });
        return;
      } else {
        cb([
          {"has_net": true, "items": objData["items"]}
        ]);
      }
    });
  }

  //POST LOGIN
  Future<void> postLogin(
      context, Map<String, dynamic> param, Function cb) async {
    HttpRequest(api: ApiKeys.gApiSubFolderPostLogin, parameters: param)
        .post()
        .then((returnPost) {
      print("returnPost $returnPost");
      if (returnPost == "No Internet") {
        CustomDialog().internetErrorDialog(context, () {
          Get.back();
          cb([
            {"has_net": false, "items": []}
          ]);
        });
        return;
      }
      if (returnPost == null) {
        CustomDialog().errorDialog(context, "Error",
            "Error while connecting to server, Please try again.", () {
          Get.back();
          cb([
            {"has_net": true, "items": []}
          ]);
        });
        return;
      }
      if (returnPost["success"] == "N") {
        CustomDialog().errorDialog(context, "Error", returnPost["msg"], () {
          Get.back();
          cb([
            {"has_net": true, "items": []}
          ]);
        });

        return;
      } else {
        var getApi =
            "${ApiKeys.gApiSubFolderLogin}?mobile_no=${param["mobile_no"]}&auth_key=${returnPost["auth_key"].toString()}";

        HttpRequest(api: getApi).get().then((objData) async {
          if (objData == "No Internet") {
            CustomDialog().internetErrorDialog(context, () {
              Get.back();
              cb([
                {"has_net": false, "items": []}
              ]);
            });
            return;
          }
          if (objData == null) {
            CustomDialog().errorDialog(context, "Error",
                "Error while connecting to server, Please try again.", () {
              Get.back();
              cb([
                {"has_net": true, "items": []}
              ]);
            });
            return;
          } else {
            if (objData["items"].length == 0) {
              CustomDialog()
                  .errorDialog(context, "Error", objData["items"]["msg"], () {
                Get.back();
                cb([
                  {"has_net": true, "items": []}
                ]);
              });
              return;
            } else {
              var items = objData["items"][0];

              Map<String, dynamic> parameters = {
                "user_id": items['user_id'].toString(),
                "mobile_no": param["mobile_no"],
                "is_active": "Y",
                "is_login": "Y",
              };

              Authentication().setLogin(jsonEncode(parameters));
              Authentication().setUserData(jsonEncode(items));
              Authentication().setPasswordBiometric(param["pwd"]);
              Authentication().setProfilePic(items["image_base64"]);

              cb([
                {"has_net": true, "items": objData["items"]}
              ]);
            }
          }
        });
      }
    });
  }

  @override
  void onInit() {
    mobileNumber = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
