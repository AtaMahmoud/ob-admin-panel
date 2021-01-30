import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/ui/widgets/desktop_main_view.dart';

class DesktopDevicesPage extends StatefulWidget {
  @override
  _DesktopDevicesPageState createState() => _DesktopDevicesPageState();
}

class _DesktopDevicesPageState extends State<DesktopDevicesPage> {
  @override
  Widget build(BuildContext context) {
    return DesktopMainView(
      view: Container(),
      viewIndex: Constants.devicesViewIndex,
    );
  }
}