import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';


class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 230,
      padding: EdgeInsets.symmetric(
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: const Color(ColorConstants.MAIN_COLOR),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        ConstantTexts.SUBMIT,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
