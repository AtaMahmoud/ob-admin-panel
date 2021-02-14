import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/ui/pages/users_page/desktop_version.dart';
import 'package:ob_admin_panel/src/ui/pages/users_page/mobile_version.dart';
import 'package:ob_admin_panel/src/ui/pages/users_page/tablet_version.dart';
import 'package:responsive_builder/responsive_builder.dart';

class UsersPage extends StatefulWidget {
  static const routeName = '/users';

  @override
  _SeapodSettingsState createState() => _SeapodSettingsState();
}

class _SeapodSettingsState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return DesktopUsersPage();
        } else if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
          return TabletUsersPage();
        } else {
          return MobileUsersPage();
        }
      },
    );
  }
}