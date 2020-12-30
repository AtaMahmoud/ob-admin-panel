import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/ui/pages/desktop_navigation_pages/desktop_seapod_details.dart';
import 'package:ob_admin_panel/src/ui/pages/mobile_navigation_pages/seapod_datails_mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SeapodDetailsPage extends StatefulWidget {
  static const routeName = '/seapod';

  @override
  _SeapodDetailsPageState createState() => _SeapodDetailsPageState();
}

class _SeapodDetailsPageState extends State<SeapodDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop)
          return DesktopSeapodDetails();
        else
          return MobileSeapodDetails();
      },
    );
  }
}
