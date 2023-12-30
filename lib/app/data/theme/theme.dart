import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color lightSecondaryColor = Color(0xff878AF5);
const Color lightPrimaryColor = Color(0xff666AF6);
const Color lightScaffoldColor = Color(0xffF7F7F7);

const Color darkPrimaryColor = Color(0xffF4863C);
const Color darkSecondaryColor = Color(0xffF5A921);
const Color darkScaffoldColor = Color(0xff191919);

const Color darkBlueColor = Color(0xff31446C);
const Color greyColor = Color(0xff999999);
const Color whiteColor = Color(0xffFAFAFA);
const Color blackColor = Color(0xff191919);
const Color errorColor = Colors.red;

TextStyle getBoldTextStyle = const TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  fontFamily: "Poppins-Bold",
  color: whiteColor,
);
TextStyle getDefaultTextStyle = const TextStyle(
  fontSize: 15,
  fontFamily: "Poppins-Regular",
  color: whiteColor,
);
TextStyle getSubtitleTextStyle = TextStyle(
  fontFamily: "Poppins-Regular",
  fontSize: 13,
  color: whiteColor.withOpacity(.9),
);

Color getPrimaryColor = Get.theme.colorScheme.primary;
Color getSecondaryColor = Get.theme.colorScheme.secondary;

class CustomTheme {
  final customLightTheme = ThemeData.light().copyWith(
    primaryColor: lightSecondaryColor,
    scaffoldBackgroundColor: lightScaffoldColor,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: lightPrimaryColor,
      onPrimary: whiteColor,
      secondary: lightSecondaryColor,
      onSecondary: whiteColor,
      error: errorColor,
      onError: whiteColor,
      background: lightScaffoldColor,
      onBackground: whiteColor,
      surface: lightPrimaryColor,
      onSurface: blackColor,
    ),
    textTheme: TextTheme(
      headlineSmall: getBoldTextStyle.copyWith(
        color: blackColor,
      ),
    ),
  );
  final customDarkTheme = ThemeData.dark().copyWith(
    primaryColor: darkPrimaryColor,
    scaffoldBackgroundColor: darkScaffoldColor,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: darkPrimaryColor,
      onPrimary: whiteColor,
      secondary: darkSecondaryColor,
      onSecondary: darkSecondaryColor,
      error: errorColor,
      onError: errorColor,
      background: darkScaffoldColor,
      onBackground: darkScaffoldColor,
      surface: darkPrimaryColor,
      onSurface: whiteColor,
    ),
    textTheme: TextTheme(
      headlineSmall: getBoldTextStyle.copyWith(
        color: blackColor,
      ),
    ),
  );
}
