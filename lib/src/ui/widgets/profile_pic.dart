import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/providers/admin_auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProfilePic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authenticatedAdmin =
        Provider.of<AdminAuthProvider>(context, listen: false)
            .authenticatedAdmin;
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        var isDesktop =
            sizingInformation.deviceScreenType == DeviceScreenType.desktop;
        return Column(
          crossAxisAlignment:
              isDesktop ? CrossAxisAlignment.center : CrossAxisAlignment.end,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(
                'assets/images/avatar.png',
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Welcome ${authenticatedAdmin.firstName}',
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
