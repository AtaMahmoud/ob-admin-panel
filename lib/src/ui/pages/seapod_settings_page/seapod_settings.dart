import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/ui/pages/seapod_settings_page/desktop_version.dart';
import 'package:ob_admin_panel/src/ui/pages/seapod_settings_page/mobile_version.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SeapodSettingsPage extends StatefulWidget {
  static const routeName = '/seapod-settings';

  @override
  _SeapodSettingsPageState createState() => _SeapodSettingsPageState();
}

class _SeapodSettingsPageState extends State<SeapodSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return DesktopSeapodSettingsPage();
        } else {
          return MobileSeapodSettingsPage();
        }
      },
    );
  }
}
