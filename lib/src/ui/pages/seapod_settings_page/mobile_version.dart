import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/ui/widgets/mobile_left_navigation_drawer.dart';

class MobileSeapodSettingsPage extends StatefulWidget {
  @override
  _MobileLocationsPageState createState() => _MobileLocationsPageState();
}

class _MobileLocationsPageState extends State<MobileSeapodSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        ColorConstants.tabBackground,
      ),
      drawer: const MobileLeftNavigationMenu(
        tappedMenuIndex: Constants.seapodSettingsViewIndex,
      ),
      drawerScrimColor: const Color(ColorConstants.drawerScrimColor),
      body: Container(),
    );
  }
}
