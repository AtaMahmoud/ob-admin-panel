import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';

class WebLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 130,
      margin: const EdgeInsets.only(
        top: 10,
        left: 15,
        bottom: 15,
      ),
      child: Image.asset(
        ImagePaths.obFullLogo,
        fit: BoxFit.fill,
      ),
    );
  }
}

class MobileLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImagePaths.obLogo,
      fit: BoxFit.contain,
      height: 40,
      width: 70,
    );
  }
}
