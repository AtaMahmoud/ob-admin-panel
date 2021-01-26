import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Scaffold(
          body: sizingInformation.deviceScreenType == DeviceScreenType.desktop
              ? Container(
                  color: Colors.white,
                )
              : Image.asset(
                  ImagePaths.splash,
                  fit: BoxFit.fill,
                  height: _mediaQuery.height,
                  width: _mediaQuery.width,
                ),
        );
      },
    );
  }
}
