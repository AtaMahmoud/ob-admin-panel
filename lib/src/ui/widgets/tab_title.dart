import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';

class TabTitle extends StatelessWidget {
  final String title;

  TabTitle(
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: Color(
            ColorConstants.TABS_TITLE_COLOR,
          ),
        ),
      ),
    );
  }
}
