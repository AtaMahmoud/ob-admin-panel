import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final bool isTapped;
  final VoidCallback onTap;

  const MenuItem({
    @required this.title,
    this.isTapped = false,
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
        color: isTapped
            ? const Color(
                ColorConstants.tappedMenuBackground,
              )
            : null,
        child: Text(
          title,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
