import 'package:get/get.dart';
import 'package:time_planner/app/controllers/authenticationModuleController.dart';
import 'package:time_planner/app/controllers/introductionModuleController.dart';

class IntroductionModuleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => IntroductionModuleController(),
    );
    Get.put(AuthenticationModuleController());
  }
}
