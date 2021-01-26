import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/ui/pages/desktop_navigation_pages/desktop_seapod_owner.dart';
import 'package:ob_admin_panel/src/ui/pages/mobile_navigation_pages/mobile_seapod_owners.dart';
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
