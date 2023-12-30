// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/theme/theme.dart';

class CustomPageIndicator extends StatelessWidget {
  final indicatorPosition;
  final currentPageIndex;
  const CustomPageIndicator(
      {Key? key,
      required this.indicatorPosition,
      required this.currentPageIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 10,
      width: currentPageIndex == indicatorPosition ? 15 : 10,
      decoration: BoxDecoration(
        color: currentPageIndex == indicatorPosition
            ? Get.theme.colorScheme.primary
            : greyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      duration: const Duration(milliseconds: 400),
    );
  }
}
