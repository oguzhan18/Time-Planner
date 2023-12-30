// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_planner/app/data/theme/theme.dart';
import '../../controllers/introductionModuleController.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final controller = Get.find<IntroductionModuleController>();

  @override
  Widget build(BuildContext context) {
    controller.triggerSplashScreen();
    return Scaffold(
      backgroundColor: Get.isDarkMode
          ? Get.theme.scaffoldBackgroundColor
          : Get.theme.colorScheme.primary,
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 5,
            ),
            Text(
              "Time Planner",
              style: getBoldTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
