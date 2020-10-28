import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/ui/pages/desktop_home_page.dart';
import 'package:ob_admin_panel/src/ui/pages/mobile_home_page.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home-page';

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop)
          return DesktopHomepage();
        else
          return MobileHomepage();
      },
    );
  }
}
