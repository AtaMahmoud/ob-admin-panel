import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/ui/widgets/mobile_left_navigation_drawer.dart';

class MobileAccessManagementPage extends StatefulWidget {
  @override
  _MobileAccessManagementPageState createState() =>
      _MobileAccessManagementPageState();
}

class _MobileAccessManagementPageState
    extends State<MobileAccessManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        ColorConstants.tabBackground,
      ),
      drawer: const MobileLeftNavigationMenu(
        tappedMenuIndex: Constants.accessManagementIndex,
      ),
      drawerScrimColor: const Color(ColorConstants.drawerScrimColor),
      body: Container(),
    );
  }
}
