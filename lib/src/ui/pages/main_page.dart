import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/ui/pages/desktop_home_page.dart';
import 'package:ob_admin_panel/src/ui/pages/mobile_navigation_pages/mobile_seapods_page.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MainPage extends StatelessWidget {
  static const routeName = 'main-page';

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop)
          return DesktopHomepage();
        else
          return MobileSeapodsPage();
      },
    );
  }
}
