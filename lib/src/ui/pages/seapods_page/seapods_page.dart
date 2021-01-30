import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/ui/pages/seapods_page/desktop_version.dart';
import 'package:ob_admin_panel/src/ui/pages/seapods_page/mobile_version.dart';

import 'package:responsive_builder/responsive_builder.dart';

class SeapodsPage extends StatefulWidget {
  static const routeName = '/seapods';

  @override
  _SeapodsPageState createState() => _SeapodsPageState();
}

class _SeapodsPageState extends State<SeapodsPage> {
  int seapodsViewIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return DesktopSeapodsPage(
            seapodsViewIndex: seapodsViewIndex,
            onListTap: () {
              setState(() {
                seapodsViewIndex = 0;
              });
            },
            onMapTap: () {
              setState(() {
                seapodsViewIndex = 1;
              });
            },
          );
        } else {
          return MobileSeapodsPage(
            seapodsViewIndex: seapodsViewIndex,
            onListTap: () {
              setState(() {
                seapodsViewIndex = 0;
              });
            },
            onMapTap: () {
              setState(() {
                seapodsViewIndex = 1;
              });
            },
          );
        }
      },
    );
  }
}
