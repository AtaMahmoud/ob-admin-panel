import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/ui/widgets/desktop_main_view.dart';

class DesktopAccessManagementPage extends StatefulWidget {
  @override
  _DesktopAccessManagementPageState createState() =>
      _DesktopAccessManagementPageState();
}

class _DesktopAccessManagementPageState
    extends State<DesktopAccessManagementPage> {
  @override
  Widget build(BuildContext context) {
    return DesktopMainView(
      view: Container(),
      viewIndex: Constants.accessManagementIndex,
    );
  }
}
