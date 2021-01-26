import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/providers/admin_auth_provider.dart';
import 'package:ob_admin_panel/src/ui/pages/home_page.dart';
import 'package:ob_admin_panel/src/ui/pages/login.dart';
import 'package:ob_admin_panel/src/ui/widgets/mobile_menu_item.dart';
import 'package:ob_admin_panel/src/ui/widgets/profile_pic.dart';
import 'package:provider/provider.dart';

class MobileLeftNavigationMenu extends StatelessWidget {
  final int tappedMenuIndex;
 const MobileLeftNavigationMenu({
    @required this.tappedMenuIndex,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return SizedBox(
      width: mediaQuery.width * 0.56,
      child: Drawer(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 2.0,
            sigmaY: 2.0,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: mediaQuery.height -
                    MediaQuery.of(context).padding.bottom -
                    MediaQuery.of(context).padding.top,
                color: const Color(ColorConstants.loginRegisterTextColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Stack(
                        children: [
                          Builder(
                            builder: (
                              BuildContext context,
                            ) =>
                                IconButton(
                              icon: const Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: 35.0,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, right: 5),
                              child: ProfilePic(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ...[
                      for (int i = 0; i < Constants.tabCount; i++) ...[
                        _buildNavigationMenues(
                            tappedMenuIndex == i, context)[i],
                      ]
                    ],
                   const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () => logout(context),
                      child: const MenuItem(
                        title: ConstantTexts.logout,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildNavigationMenues(
    bool isTapped,
    BuildContext context,
  ) {
    return [
      MenuItem(
        title: ConstantTexts.home,
        isTapped: isTapped,
        onTap: () {
          Navigator.of(context).pushReplacementNamed(HomePage.routeName);
        },
      ),
      MenuItem(
        title: ConstantTexts.weatherMarine,
        isTapped: isTapped,
      ),
      MenuItem(
        title: ConstantTexts.devices,
        isTapped: isTapped,
      ),
      MenuItem(
        title: ConstantTexts.messages,
        isTapped: isTapped,
      ),
      MenuItem(
        title: ConstantTexts.acceseManagement,
        isTapped: isTapped,
      ),
      MenuItem(
        title: ConstantTexts.locations,
        isTapped: isTapped,
      ),
      MenuItem(
        title: ConstantTexts.users,
        isTapped: isTapped,
      ),
      MenuItem(
        title: ConstantTexts.seapodsSettings,
        isTapped: isTapped,
      ),
    ];
  }

  Future<void> logout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => const SpinKitFadingCircle(
        color: Color(ColorConstants.mainColor),
      ),
    );
    await Provider.of<AdminAuthProvider>(context, listen: false).logout();
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
  }
}
