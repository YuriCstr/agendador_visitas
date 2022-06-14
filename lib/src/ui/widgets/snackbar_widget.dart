import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackBar(String title, String message, Color backgroundColor) {
  Get.snackbar(title, message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor,
      duration: Duration(seconds: 1),
      colorText: Colors.white);
}
