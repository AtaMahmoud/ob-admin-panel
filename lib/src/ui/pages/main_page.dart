import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/ui/pages/desktop_navigation_pages/desktop_home_page.dart';
import 'package:ob_admin_panel/src/ui/pages/mobile_navigation_pages/mobile_home_page.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop)
          return DesktopHomepage(
            tabIndex: tabIndex,
            onListTap: () {
              setState(() {
                tabIndex = 0;
              });
            },
            onMapTap: () {
              setState(() {
                tabIndex = 1;
              });
            },
            onMoreButtonTap: () {
              setState(() {
                tabIndex = 2;
              });
            },
          );
        else
          return MobileHomePage(
            tabIndex: tabIndex,
            onListTap: () {
              setState(() {
                tabIndex = 0;
              });
            },
            onMapTap: () {
              setState(() {
                tabIndex = 1;
              });
            },
            onMoreButtonTap: () {
              setState(() {
                tabIndex = 2;
              });
            },
          );
      },
    );
  }
}
