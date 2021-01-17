import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/ui/pages/desktop_navigation_pages/desktop_home_page.dart';
import 'package:ob_admin_panel/src/ui/pages/mobile_navigation_pages/mobile_home_page.dart';
import 'package:ob_admin_panel/src/ui/pages/seapod_datails.dart';
import 'package:ob_admin_panel/src/ui/pages/seapod_owner_page.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  final bool seapodDetailsPage;
  final bool seapodOwnerPage;

  HomePage({
    this.seapodDetailsPage = false,
    this.seapodOwnerPage = false,
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
            seapodsTabIndex: homeTabsIndex,
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
            seapodDetailsPage: widget.seapodDetailsPage,
            seapodOwnerScreen: widget.seapodOwnerPage,
          );
        else {
          if (widget.seapodDetailsPage)
            return SeapodDetailsPage();
          else if (widget.seapodOwnerPage)
            return SeapodOwnersPage();
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
            );
        }
      },
    );
  }
}
