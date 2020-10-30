import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final bool isTapped;

  MenuItem({@required this.title, this.isTapped = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      padding: EdgeInsets.only(
        left: 15,
        top: 10,
      ),
      color: isTapped
          ? Color(
              ColorConstants.TAPPED_MENU_BACKGROUND,
            )
          : null,
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}
