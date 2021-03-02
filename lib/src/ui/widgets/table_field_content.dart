import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';

class TableFieldContent extends StatelessWidget {
  const TableFieldContent({
    @required this.text,
    this.color,
  });
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 5,
            right: 10,
            bottom: 5,
          ),
          child: Text(
            text,
            textAlign: TextAlign.start,
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
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: color ?? const Color(ColorConstants.textColor),
    );
  }
}
