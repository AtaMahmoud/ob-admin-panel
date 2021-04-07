import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';

class DevicesFieldContent extends StatelessWidget {
  const DevicesFieldContent({
    @required this.text,
    @required this.visible,
    this.color,
    this.textAlign = TextAlign.start,
  });

  final String text;
  final bool visible;
  final Color color;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: SizedBox(
        width: Constants.tableFieldWidth,
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0),
          child: Text(
            text,
            textAlign: textAlign,
            style: tableContentTextStyle(
              color: color,
            ),
          ),
        ),
      ),
    );
  }

  TextStyle tableContentTextStyle({
    Color color,
  }) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: color ?? const Color(ColorConstants.textColor),
    );
  }
}
