import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/ui/pages/devices_page/desktop_version.dart';
import 'package:ob_admin_panel/src/ui/pages/devices_page/mobile_version.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DevicesPage extends StatelessWidget {
  static const routeName = '/devices';

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return DesktopDevicesPage();
        } else {
          return MobileDevicesPage();
        }
      },
    );
  }
}