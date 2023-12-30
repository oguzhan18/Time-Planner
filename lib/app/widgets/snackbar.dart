import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar({required String title, required String message}) {
  Get.snackbar(
    title,
    message,
    backgroundColor: Get.theme.scaffoldBackgroundColor.withOpacity(.5),
    borderRadius: 8,
    borderColor: Get.theme.colorScheme.primary,
    borderWidth: 1,
    margin: const EdgeInsets.all(10),
    duration: const Duration(seconds: 3),
  );
}
