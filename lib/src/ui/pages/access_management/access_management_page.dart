import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/ui/pages/access_management/desktop_version.dart';
import 'package:ob_admin_panel/src/ui/pages/access_management/mobile_version.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AccessManagementPage extends StatelessWidget {
  static const routeName = '/access_management';

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return DesktopAccessManagementPage();
        } else {
          return MobileAccessManagementPage();
        }
      },
    );
  }
}
