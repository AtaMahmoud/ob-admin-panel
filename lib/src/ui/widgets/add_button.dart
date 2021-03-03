import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    Key key,
  }) : super(key: key);

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
        height: 54,
        child: const Center(
          child: Icon(
            CupertinoIcons.add,
            size: 40,
            color: Color(ColorConstants.addSeapodColor),
          ),
        ),
      ),
    );
  }
}