import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/ui/widgets/mobile_left_navigation_drawer.dart';

class MobileSeapodLocationsPage extends StatefulWidget {
  @override
  _MobileSeapodLocationsPageState createState() => _MobileSeapodLocationsPageState();
}

class _MobileSeapodLocationsPageState extends State<MobileSeapodLocationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        ColorConstants.tabBackground,
      ),
      drawer: const MobileLeftNavigationMenu(
        tappedMenuIndex: Constants.homeIndex,
      ),
      drawerScrimColor: const Color(ColorConstants.drawerScrimColor),
      body: Container(),
    );
  }
}