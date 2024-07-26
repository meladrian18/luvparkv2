import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luvpark_get/classes/app_color.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

BuildContext? ctxt;

class Variables {
  static late Size screenSize;
  static void init(BuildContext context) {
    ctxt = context;
    screenSize = MediaQuery.of(context).size;
  }

  static String paMessageTable = 'pa_message';
  static String vhBrands = 'vehicle_brands';
  static String locSharing = 'location_sharing_table';
  static String notifTable = 'notification_table';
  static String shareLocTable = 'share_location_table';
  //static void Timer? backgroundTimer
  static final emailRegex = RegExp(
    r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  static var maskFormatter = MaskTextInputFormatter(
      mask: '### ### ####', filter: {"#": RegExp(r'[0-9]')});

  static String mobileRegex = r"^[1-9]\d{9}$";

  static String mapApiKey = 'AIzaSyCaDHmbTEr-TVnJY8dG0ZnzsoBH3Mzh4cE';
  static String popUpMessageOutsideArea =
      'Booking request denied. Location exceeds service area. Check and update location information.';
  static String popUpMessageOutsideAreas =
      'Location exceeds service area. Check and update location information. Retry booking.';
  static String version = "";
  static int loginAttemptCount = 0;

//Data Encryption
  static bool withinOneHourRange(DateTime targetDateTime) {
    DateTime currentDateTime = DateTime.now();
    DateTime oneHourAgo = currentDateTime.subtract(Duration(hours: 1));
    return targetDateTime.isAfter(oneHourAgo) &&
        targetDateTime.isBefore(currentDateTime);
  }

  static String arrayBufferToBase64(ByteBuffer buffer) {
    var bytes = Uint8List.view(buffer);
    var base64String = base64.encode(bytes);
    return base64String;
  }

  static Uint8List hexStringToArrayBuffer(String hexString) {
    final result = Uint8List(hexString.length ~/ 2);
    for (var i = 0; i < hexString.length; i += 2) {
      result[(i ~/ 2)] = int.parse(hexString.substring(i, i + 2), radix: 16);
    }
    return result;
  }

  static ByteBuffer concatBuffers(Uint8List buffer1, Uint8List buffer2) {
    final tmp = Uint8List(buffer1.length + buffer2.length);
    tmp.setAll(0, buffer1);
    tmp.setAll(buffer1.length, buffer2);
    return tmp.buffer;
  }

  static Uint8List generateRandomNonce() {
    var random = Random.secure();
    var iv = Uint8List(16);
    for (var i = 0; i < iv.length; i++) {
      iv[i] = random.nextInt(256);
    }
    return iv;
  }

  static String capitalize(String value) {
    if (value.trim().isEmpty) return "";
    return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
  }

  static String hideName(String name) {
    if (name.isEmpty) {
      return ''; // Handle empty names as needed
    } else if (name.length == 1) {
      return name; // Show the full name if it's 2 characters or less
    } else if (name.length == 2) {
      return "${name[0]}*"; // Show the full name if it's 2 characters or less
    } else if (name.length == 3) {
      return "${name.substring(0, 2)}*"; // Show the full name if it's 2 characters or less
    } else {
      return '${name.substring(0, 2)}${'*' * (name.length - 2)}'; // Show the first two letters and the rest with asterisks
    }
  }

  static String transformFullName(String fullName) {
    if (fullName.isEmpty) {
      return ''; // Handle empty names as needed
    }

    List<String> nameParts = [];
    if (fullName.contains(" ")) {
      nameParts = fullName.split(" ");
    } else {
      nameParts = [fullName];
    }
    String transformedFullName = '';
    for (var name in nameParts) {
      if (transformedFullName.isNotEmpty) {
        transformedFullName += ' '; // Add space between names
      }
      transformedFullName += hideName(name);
    }

    return transformedFullName;
  }

  static Future<void> pageTrans(Widget param, BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => param),
    );
  }

  static String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  static String displayLastFourDigitsWithAsterisks(int number) {
    String numberString = number.toString();
    if (numberString.length >= 4) {
      String asterisks = '●' * (numberString.length - 4);
      return '$asterisks${numberString.substring(numberString.length - 4)}';
    } else {
      // Handle cases where the number has less than four digits
      return numberString;
    }
  }

  static var regExpRestrictFormatter =
      FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9]+|\s"));

//Password strength validation
  static int getPasswordStrength(String password) {
    if (password.isEmpty) {
      return 0;
    } else if (password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[0-9]'))) {
      return 4; // Strong
    } else if ((password.length >= 8 && password.contains(RegExp(r'[0-9]'))) ||
        (password.length >= 8 && password.contains(RegExp(r'[A-Z]')))) {
      return 3; // Medium
    } else if (password.length >= 8 ||
        (password.contains(RegExp(r'[0-9]')) ||
            password.contains(RegExp(r'[A-Z]')))) {
      return 2; // Weak
    } else {
      return 1; // Very Weak
    }
  }

//Password strength validation
  static String getPasswordStrengthText(int strength) {
    switch (strength) {
      case 1:
        return 'Very Weak Password';
      case 2:
        return 'Weak Password';
      case 3:
        return 'Medium Password';
      case 4:
        return 'Strong Password';
      default:
        return '';
    }
  }

//Password strength validation
  static Color getColorForPasswordStrength(int strength) {
    switch (strength) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return const Color.fromARGB(255, 248, 224, 13);
      case 4:
        return AppColor.primaryColor;
      default:
        return Colors.black;
    }
  }

  //Convert to minutes
  static String convertToTime(int totalMinutes) {
    // Calculate hours and minutes
    // int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    // Format the time as HH:MM
    // String formattedTime = '$hours:${minutes.toString().padLeft(2, '0')}';

    return minutes.toString().padLeft(2, '0');
  }

  static double convertToMeters(String distanceString) {
    // Extract numeric part of the string
    String numericPart = distanceString.replaceAll(RegExp(r'[^0-9.]'), '');

    // Parse numeric part to double
    double distanceValue = double.tryParse(numericPart) ?? 0;

    // Check if "km" (kilometers) is present in the string
    bool isKilometers = distanceString.toLowerCase().contains('km');

    // Convert to meters
    return isKilometers ? distanceValue * 1000 : distanceValue;
  }

  //COnvert 12 hours format sample:18:00
  static String convert24HourTo12HourFormat(String time24Hour) {
    List<String> parts = time24Hour.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);

    String period = hours < 12 ? 'AM' : 'PM';
    hours = hours % 12;
    hours = hours == 0 ? 12 : hours; // Convert 0 to 12 for 12-hour format

    return "$hours:${minutes.toString().padLeft(2, '0')} $period";
  }

  //Split by 2 sample:1800
  static List<String> splitNumberIntoPairs(String numberString, int pairSize) {
    List<String> digitPairs = [];

    for (int i = 0; i < numberString.length; i += pairSize) {
      int end = i + pairSize;
      if (end > numberString.length) {
        end = numberString.length;
      }
      digitPairs.add(numberString.substring(i, end));
    }

    return digitPairs;
  }

  //Generate a list of number  with a specified length
  static List<int> generateNumberList(int length) {
    return List.generate(length, (index) => index + 1);
  }

  //2020-20-20 to 2020/20/20
  static String formatDate(String inputDateString) {
    String _twoDigits(int n) {
      // Helper function to add leading zeros to single-digit numbers
      return n.toString().padLeft(2, '0');
    }

    // Parse the input date string into a DateTime object
    DateTime dateTime = DateTime.parse(inputDateString);

    // Format the DateTime object into the desired string format
    String formattedDateString =
        "${dateTime.year}/${_twoDigits(dateTime.month)}/${_twoDigits(dateTime.day)}";

    return formattedDateString;
  }

  static customBottomSheet(BuildContext context, Widget child) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return child;
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      // Custom animation for smooth transition
      transitionAnimationController: AnimationController(
        vsync: Navigator.of(context),
        duration: Duration(milliseconds: 400),
      ),
    );
  }
}
