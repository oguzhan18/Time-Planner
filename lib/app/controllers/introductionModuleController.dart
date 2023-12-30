import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:time_planner/app/controllers/authenticationModuleController.dart';
import 'package:time_planner/app/routes/routes.dart';

import '../services/authenticationFunctions.dart';

class IntroductionModuleController {
  var currentPageIndex = 0.obs;

  void triggerSplashScreen() async {
    bool isFirstBoot = await checkIfItsFirstBoot();
    await Future.delayed(const Duration(seconds: 2));
    isFirstBoot
        ? Get.offNamed(ROUTES.getOnBoardingScreenRoute)
        : checkIfUserIsLoggedInOrNot();
  }

  void checkIfUserIsLoggedInOrNot() async {
    if (FirebaseAuth.instance.currentUser != null) {
      final AuthenticationModuleController authenticationModuleController =
          Get.find();
      authenticationModuleController.userModel =
          await AuthenticationFunctions().getUserData();
      Get.offNamed(ROUTES.getHomeScreenRoute);
    } else {
      Get.offNamed(ROUTES.getLoginScreenRoute);
    }
  }

  Future<bool> checkIfItsFirstBoot() async {
    final box = GetStorage();
    var isFirstBoot = await box.read("isFirstBoot");
    if (isFirstBoot == null) {
      box.write("isFirstBoot", false);
      return true;
    } else {
      return false;
    }
  }

  void onNextButtonClick() {
    if (currentPageIndex.value < 2) {
      currentPageIndex.value++;
    } else {
      Get.offNamed(ROUTES.getLoginScreenRoute);
    }
  }
}
