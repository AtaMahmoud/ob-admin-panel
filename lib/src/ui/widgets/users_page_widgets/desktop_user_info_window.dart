import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/ui/widgets/users_page_widgets/user_info_list.dart';
import 'package:speech_bubble/speech_bubble.dart';

class DesktopUserInfoWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpeechBubble(
      nipLocation: NipLocation.TOP_LEFT,
      offset: const Offset(15, 0),
      nipHeight: 20.0,
      borderRadius: 7.0,
      color:
          const Color(ColorConstants.loginRegisterTextColor).withOpacity(0.8),
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: const UserInfoList(),
    );
  }
}
