import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/ui/pages/mobile_navigation_pages/seapod_datails_mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SeapodDetailsPage extends StatelessWidget {
  static const routeName = '/seapod';

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
       /*  if (sizingInformation.deviceScreenType == DeviceScreenType.desktop)
          return ;
        else */
          return MobileSeapodDetails();
      },
    );
  }
}
