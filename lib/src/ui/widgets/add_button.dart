import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    Key key,
    this.height = 54.0,
    this.iconSize = 40.0,
  }) : super(key: key);

  final double iconSize;
  final double height;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: const Color(ColorConstants.addSeapodColor),
      dashPattern: const [8],
      borderType: BorderType.RRect,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        height: height,
        child: Center(
          child: Icon(
            CupertinoIcons.add,
            size: iconSize,
            color: const Color(ColorConstants.addSeapodColor),
          ),
        ),
      ),
    );
  }
}
