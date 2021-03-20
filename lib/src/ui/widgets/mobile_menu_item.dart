import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final Color titleColor;
  final bool isSelected;
  final VoidCallback onTap;

  const MenuItem({
    @required this.title,
    this.titleColor = Colors.white,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 40,
        padding: const EdgeInsets.only(
          left: 15,
          top: 10,
        ),
        color: isSelected
            ? const Color(
                ColorConstants.tappedMenuBackground,
              )
            : null,
        child: Text(
          title,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: titleColor,
          ),
        ),
      ),
    );
  }
}
