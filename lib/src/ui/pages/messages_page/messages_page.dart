import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/ui/pages/messages_page/desktop_version.dart';
import 'package:ob_admin_panel/src/ui/pages/messages_page/mobile_version.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MessagesPage extends StatelessWidget {
  static const routeName = '/messages';

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return DesktopMessagesPage();
        } else {
          return MobileMessagesPage();
        }
      },
    );
  }
}