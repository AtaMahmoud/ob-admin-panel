import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/ui/pages/seapod_details/desktop_version.dart';
import 'package:ob_admin_panel/src/ui/pages/seapod_details/mobile_version.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SeapodDetailsPage extends StatefulWidget {
  static const routeName = '/seapod-info';

  @override
  _SeapodDetailsPageState createState() => _SeapodDetailsPageState();
}

class _SeapodDetailsPageState extends State<SeapodDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return DesktopSeapodDetails();
        } else {
          return MobileSeapodDetails();
        }
      },
    );
  }
}
