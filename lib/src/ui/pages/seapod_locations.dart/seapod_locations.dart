import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/ui/pages/seapod_locations.dart/desktop_version.dart';
import 'package:ob_admin_panel/src/ui/pages/seapod_locations.dart/mobile_version.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SeapodLocationsPage extends StatelessWidget {
  static const routeName = '/seapod-locations';

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return DesktopSeapodLocationsPage();
        } else {
          return MobileSeapodLocationsPage();
        }
      },
    );
  }
}
