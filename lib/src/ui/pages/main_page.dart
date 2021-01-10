import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/ui/pages/desktop_navigation_pages/desktop_home_page.dart';
import 'package:ob_admin_panel/src/ui/pages/mobile_navigation_pages/mobile_home_page.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  final bool showSeapodDetailsPage;

  HomePage({
    this.showSeapodDetailsPage = false,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int homeTabsIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop)
          return DesktopHomepage(
            tabIndex: homeTabsIndex,
            onListTap: () {
              setState(() {
                homeTabsIndex = 0;
              });
            },
            onMapTap: () {
              setState(() {
                homeTabsIndex = 1;
              });
            },
            showSeapodDetailsPage: widget.showSeapodDetailsPage,
          );
        else
          return MobileHomePage(
            tabIndex: homeTabsIndex,
            onListTap: () {
              setState(() {
                homeTabsIndex = 0;
              });
            },
            onMapTap: () {
              setState(() {
                homeTabsIndex = 1;
              });
            },
            showSeapodDetailsPage: widget.showSeapodDetailsPage,
          );
      },
    );
  }
}
