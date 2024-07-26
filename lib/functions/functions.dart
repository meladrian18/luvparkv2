import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:luvpark_get/auth/authentication.dart';
import 'package:luvpark_get/classes/alert_dialog.dart';
import 'package:luvpark_get/http/api_keys.dart';
import 'package:luvpark_get/http/http_request.dart';
import 'package:luvpark_get/sqlite/pa_message_table.dart';
import 'package:luvpark_get/sqlite/reserve_notification_table.dart';
import 'package:luvpark_get/sqlite/share_location_table.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;

import '../notification_controller/notification_controller.dart';

class Functions {
  static GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
  static Future<void> getUserBalance(context, Function cb) async {
    Authentication().getUserData().then((userData) {
      if (userData == null) {
        cb([
          {"has_net": true, "success": false, "items": []}
        ]);
        CustomDialog().errorDialog(context, "", "No data found.", () {
          Get.back();
        });
      } else {
        var user = jsonDecode(userData);

        String subApi =
            "${ApiKeys.gApiSubFolderGetBalance}?user_id=${user["user_id"]}";

        HttpRequest(api: subApi).get().then((returnBalance) async {
          if (returnBalance == "No Internet") {
            CustomDialog().errorDialog(context, "Error",
                "Please check your internet connection and try again.", () {
              Get.back();
              cb([
                {"has_net": false, "success": false, "items": []}
              ]);
            });
            return;
          }
          if (returnBalance == null) {
            cb([
              {"has_net": true, "success": false, "items": []}
            ]);

            CustomDialog().errorDialog(
              context,
              "Error",
              "Error while connecting to server, Please try again.",
              () {
                Get.back();
              },
            );

            return;
          } else {
            cb([
              {
                "has_net": true,
                "success": true,
                "items": returnBalance["items"]
              }
            ]);
          }
        });
      }
    });
    // final prefs = await SharedPreferences.getInstance();
    // var myData = prefs.getString(
    //   'userData',
    // );
  }

  Future<void> loginFunc(pass, mobile, context, Function cb) async {
    final prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> postParam = {
      "mobile_no": mobile,
      "pwd": pass,
    };
    HttpRequest(api: ApiKeys.gApiSubFolderPostLogin, parameters: postParam)
        .post()
        .then((returnPost) {
      if (returnPost == "No Internet") {
        CustomDialog().internetErrorDialog(context, () {
          cb("No Internet");
          Get.back();
        });

        return;
      }

      if (returnPost == null) {
        CustomDialog().errorDialog(
          context,
          "Error",
          "Error while connecting to server, Please try again.",
          () {
            cb("null");
            Get.back();
          },
        );

        return;
      } else {
        if (returnPost["success"] == "N") {
          CustomDialog().errorDialog(
            context,
            "Error",
            "${returnPost["msg"]}",
            () {
              cb("null");
              Get.back();
            },
          );
          return;
        }
        if (returnPost["success"] == 'Y') {
          var getApi =
              "${ApiKeys.gApiSubFolderLogin}?mobile_no=$mobile&auth_key=${returnPost["auth_key"].toString()}";
          HttpRequest(api: getApi).get().then((objData) async {
            if (objData == "No Internet") {
              CustomDialog().internetErrorDialog(context, () {
                cb("No Internet");
                Get.back();
              });

              return;
            }

            if (objData == null) {
              //   Navigator.of(context).pop();
              CustomDialog().errorDialog(
                context,
                "Error",
                "Error while connecting to server, Please try again.",
                () {
                  cb("null");
                  Get.back();
                },
              );

              return;
            } else {
              if (objData["items"].length == 0) {
                CustomDialog().errorDialog(
                  context,
                  "Error",
                  objData["items"]["msg"],
                  () {
                    cb("null");
                    Get.back();
                  },
                );

                return;
              } else {
                if (objData["items"][0]["msg"] == 'Y') {
                  //    final service = FlutterBackgroundService();
                  prefs.remove('loginData');
                  prefs.remove('userData');
                  prefs.remove('geo_connect_id');
                  var items = objData["items"][0];

                  var logData = prefs.getString(
                    'loginData',
                  );
                  var myId = prefs.getString(
                    'myId',
                  );
                  prefs.setBool('isLoggedIn', true);

                  //   service.invoke("stopService");
                  tz.initializeTimeZones();

                  if (logData == null) {
                    Map<String, dynamic> parameters = {
                      "mobile_no": mobile,
                      "is_active": "Y",
                    };
                    await prefs.setString('loginData', jsonEncode(parameters));
                    Authentication().setPasswordBiometric(pass);
                  } else {
                    var logData2 = prefs.getString(
                      'loginData',
                    );

                    var mappedLogData = [jsonDecode(logData2!)];
                    mappedLogData[0]["is_active"] = "Y";
                    await prefs.setString(
                        'loginData', jsonEncode(mappedLogData[0]));

                    Authentication().setPasswordBiometric(pass);
                  }

                  // ignore: use_build_context_synchronously
                  if (myId != null) {
                    if (int.parse(myId.toString()) !=
                        int.parse(items['user_id'].toString())) {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      await NotificationDatabase.instance.deleteAll();
                      NotificationController.cancelNotifications();
                      NotificationDatabase.instance.deleteAll();
                      PaMessageDatabase.instance.deleteAll();
                      ShareLocationDatabase.instance.deleteAll();
                      pref.remove('myId');
                      pref.clear();
                      var mPinParams = {
                        "user_id": items['user_id'].toString(),
                        "is_on": "N"
                      };

                      HttpRequest(
                              api: ApiKeys.gApiSubFolderPutSwitch,
                              parameters: mPinParams)
                          .put();
                    }
                  }

                  await prefs.setString('myId', items['user_id'].toString());
                  await prefs.setString('userData', jsonEncode(items));
                  await prefs.setString(
                      'myProfilePic', jsonEncode(items["image_base64"]));

                  cb([true, "Success"]);
                  prefs.remove(
                    'provinceData',
                  );
                  prefs.remove(
                    'cityData',
                  );
                  prefs.remove(
                    'brgyData',
                  );

                  //Variables.pageTrans(const MainLandingScreen(), context);
                } else {
                  if (objData["items"][0]["msg"] == 'Not Yet Registered') {
                    CustomDialog().confirmationDialog(
                        context,
                        "Inactive Account",
                        "Your account is currently inactive. Would you like to activate it now?",
                        "Yes",
                        "No", () {
                      cb([false, "No"]);
                      Get.back();
                    }, () {
                      cb([false, "No"]);
                      Get.back();
                    });

                    return;
                  } else {
                    CustomDialog().errorDialog(
                      context,
                      "Error",
                      objData["items"][0]["msg"],
                      () {
                        cb([false, "No"]);
                        Get.back();
                      },
                    );

                    return;
                  }
                }
              }
            }
          });
        }
      }
    });
  }

  static Future<void> getLocation(BuildContext context, Function cb) async {
    try {
      List ltlng = await Functions.getCurrentPosition();

      if (ltlng.isNotEmpty) {
        Map<String, dynamic> firstItem = ltlng[0];
        if (firstItem.containsKey('lat') && firstItem.containsKey('long')) {
          double lat = double.parse(firstItem['lat'].toString());
          double long = double.parse(firstItem['long'].toString());
          cb(LatLng(lat, long));
        } else {
          cb(null);
        }
      } else {
        cb(null);
      }
    } catch (e) {
      cb(null);
    }
  }

  static Future<List> getCurrentPosition() async {
    final position = await geolocatorPlatform.getCurrentPosition();

    return [
      {"lat": position.latitude, "long": position.longitude}
    ];
  }
}
