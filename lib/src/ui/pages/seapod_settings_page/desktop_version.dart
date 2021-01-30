import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/ui/widgets/desktop_main_view.dart';

class DesktopSeapodSettingsPage extends StatefulWidget {
  @override
  _DesktopLocationsPageState createState() => _DesktopLocationsPageState();
}

class _DesktopLocationsPageState extends State<DesktopSeapodSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return DesktopMainView(
      view: Container(),
      viewIndex: Constants.seapodSettingsViewIndex,
    );
  }
}
