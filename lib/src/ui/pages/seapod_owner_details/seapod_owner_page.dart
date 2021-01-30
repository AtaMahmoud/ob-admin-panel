import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/ui/pages/seapod_owner_details/desktop_version.dart';
import 'package:ob_admin_panel/src/ui/pages/seapod_owner_details/mobile_version.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SeapodOwnersPage extends StatelessWidget {
  static const routeName = '/seapod-owner';

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return DesktopSeapodOwner();
        } else if (sizingInformation.deviceScreenType ==
            DeviceScreenType.tablet) {
          return SeapodsOwnerTabletVersion();
        } else {
          return MobileSeapodOwner();
        }
      },
    );
  }
}
