import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/ui/pages/locations_page/desktop_version.dart';
import 'package:ob_admin_panel/src/ui/pages/locations_page/mobile_version.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LocationsPage extends StatelessWidget {
  static const routeName = '/locations';

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return DesktopLocationsPage();
        } else {
          return MobileLocationsPage();
        }
      },
    );
  }
}