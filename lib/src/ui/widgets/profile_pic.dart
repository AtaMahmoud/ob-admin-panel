import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProfilePic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        var isDesktop =
            sizingInformation.deviceScreenType == DeviceScreenType.desktop;
        return Column(
          crossAxisAlignment:
              isDesktop ? CrossAxisAlignment.center : CrossAxisAlignment.end,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(
                'assets/images/avatar.png',
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Welcome Shimaa',
              style: TextStyle(
                fontSize: isDesktop ? 14 : 13,
                color: isDesktop ? Colors.black : Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        );
      },
    );
  }
}
