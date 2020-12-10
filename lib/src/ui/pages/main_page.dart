import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/ui/pages/desktop_navigation_pages/desktop_home_page.dart';
import 'package:ob_admin_panel/src/ui/pages/mobile_navigation_pages/mobile_home_page.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop)
          return DesktopHomepage();
        else
          return MobileHomePage();
      },
    );
  }
}
