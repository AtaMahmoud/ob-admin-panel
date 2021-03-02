import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';

class TabTitle extends StatelessWidget {
  final String title;
  final double fontSize;

  const TabTitle(
    this.title, {
    this.fontSize = 25.0,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: const Color(
          ColorConstants.tabsTitleColor,
        ),
      ),
    );
  }
}
