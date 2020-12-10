import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';

class TabTitle extends StatelessWidget {
  final String title;
  final double fontSize;

  TabTitle(
    this.title, {
    this.fontSize = 26.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: Color(
            ColorConstants.TABS_TITLE_COLOR,
          ),
        ),
      ),
    );
  }
}
