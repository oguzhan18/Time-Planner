import 'package:get/get.dart';
import 'package:time_planner/app/controllers/authenticationModuleController.dart';

class AuthenticationModuleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AuthenticationModuleController(),
    );
  }
}
