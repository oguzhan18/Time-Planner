import 'package:flutter/material.dart';

import '../data/theme/theme.dart';

class CustomSocialMediaButtons extends StatelessWidget {
  final IconData icon;
  final Function? onTap;
  final Color color;
  const CustomSocialMediaButtons(
      {Key? key, required this.icon, required this.onTap, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap!(),
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(60),
        ),
        child: Icon(
          icon,
          color: whiteColor,
        ),
      ),
    );
  }
}
