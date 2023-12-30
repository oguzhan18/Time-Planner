import 'package:get/get.dart';
import 'package:time_planner/app/controllers/bindings/homeModuleBinding.dart';
import 'package:time_planner/app/controllers/bindings/authenticationModuleBinding.dart';
import 'package:time_planner/app/controllers/bindings/introductionModuleBinding.dart';
import 'package:time_planner/app/views/auth/loginScreen.dart';
import 'package:time_planner/app/views/home/homescreen.dart';
import 'package:time_planner/app/views/onboarding/onBoardingScreen.dart';
import 'package:time_planner/app/views/onboarding/splashScreen.dart';

class ROUTES {
  static get getSplashScreenRoute => "/onboarding/splashscreen";
  static get getOnBoardingScreenRoute => "/onboarding/onboardingscreen";
  static get getLoginScreenRoute => '/auth/loginscreeb';
  static get getHomeScreenRoute => '/home/homescreen';
  static List<GetPage> routes = [
    GetPage(
      name: getSplashScreenRoute,
      page: () => SplashScreen(),
      binding: IntroductionModuleBinding(),
    ),
    GetPage(
      name: getOnBoardingScreenRoute,
      page: () => OnBoardingScreen(),
      binding: IntroductionModuleBinding(),
    ),
    GetPage(
      name: getLoginScreenRoute,
      page: () => LoginScreen(),
      binding: AuthenticationModuleBinding(),
    ),
    GetPage(
      name: getHomeScreenRoute,
      page: () => const Homescreen(),
      binding: HomeModuleBinding(),
    ),
  ];
}
