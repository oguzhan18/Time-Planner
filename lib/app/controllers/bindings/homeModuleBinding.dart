import 'package:get/get.dart';
import 'package:time_planner/app/controllers/homeModuleController.dart';

class HomeModuleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeModuleController(),
    );
  }
}
