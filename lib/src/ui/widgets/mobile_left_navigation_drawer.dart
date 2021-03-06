import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/constants/constant_texts.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/constants/image_paths.dart';
import 'package:ob_admin_panel/src/providers/admin_auth_provider.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/pages/access_management/access_management_page.dart';
import 'package:ob_admin_panel/src/ui/pages/devices_page/devices_page.dart';
import 'package:ob_admin_panel/src/ui/pages/locations_page/locations_page.dart';
import 'package:ob_admin_panel/src/ui/pages/login_page.dart';
import 'package:ob_admin_panel/src/ui/pages/messages_page/messages_page.dart';
import 'package:ob_admin_panel/src/ui/pages/seapod_settings_page/seapod_settings.dart';
import 'package:ob_admin_panel/src/ui/pages/seapods_page/seapods_page.dart';
import 'package:ob_admin_panel/src/ui/pages/users_page/users_page.dart';
import 'package:ob_admin_panel/src/ui/pages/weather_page/weather_page.dart';
import 'package:ob_admin_panel/src/ui/widgets/mobile_menu_item.dart';
import 'package:ob_admin_panel/src/ui/widgets/profile_pic.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MobileLeftNavigationMenu extends StatelessWidget {
  final int tappedMenuIndex;
  const MobileLeftNavigationMenu({
    @required this.tappedMenuIndex,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return ResponsiveBuilder(
      builder: (context, sizingInfo) {
        return SizedBox(
          width: sizingInfo.deviceScreenType == DeviceScreenType.tablet
              ? mediaQuery.width * 0.35
              : mediaQuery.width * 0.56,
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
                                    GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 20.0,
                                      left: 15.0,
                                    ),
                                    child: Image.asset(
                                      ImagePaths.hamburgerMenu,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, right: 5),
                                  child: ProfilePic(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ..._buildNavigationMenues(context),
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
      },
    );
  }

  List<Widget> _buildNavigationMenues(
    BuildContext context,
  ) {
    final selectedSeapod =
        Provider.of<SeaPodsProvider>(context, listen: false).selectedSeapod;
    final home = MenuItem(
      titleColor: selectedSeapod == null
          ? Colors.white
          : const Color(ColorConstants.mainColor),
      title: selectedSeapod != null
          ? selectedSeapod.seaPodName
          : ConstantTexts.home,
      isSelected: tappedMenuIndex == Constants.homeIndex,
      onTap: () {
        Navigator.of(context).pushReplacementNamed(SeapodsPage.routeName);
      },
    );
    return selectedSeapod == null
        ? [
            home,
            MenuItem(
              title: ConstantTexts.users.toUpperCase(),
              isSelected: tappedMenuIndex == Constants.usersViewIndex,
              onTap: () {
                Navigator.of(context).pushNamed(UsersPage.routeName);
              },
            ),
          ]
        : [
            home,
            MenuItem(
              title: ConstantTexts.weatherMarine,
              isSelected: tappedMenuIndex == Constants.weatherViewIndex,
              onTap: () {
                Navigator.of(context).pushNamed(WeatherPage.routeName);
              },
            ),
            MenuItem(
              title: ConstantTexts.devices.toUpperCase(),
              isSelected: tappedMenuIndex == Constants.devicesViewIndex,
              onTap: () {
                Navigator.of(context).pushNamed(DevicesPage.routeName);
              },
            ),
            MenuItem(
              title: ConstantTexts.messages,
              isSelected: tappedMenuIndex == Constants.messagesViewIndex,
              onTap: () {
                Navigator.of(context).pushNamed(MessagesPage.routeName);
              },
            ),
            MenuItem(
              title: ConstantTexts.acceseManagement,
              isSelected: tappedMenuIndex == Constants.accessManagementIndex,
              onTap: () {
                Navigator.of(context).pushNamed(AccessManagementPage.routeName);
              },
            ),
            MenuItem(
              title: ConstantTexts.locations,
              isSelected: tappedMenuIndex == Constants.locationsViewIndex,
              onTap: () {
                Navigator.of(context).pushNamed(LocationsPage.routeName);
              },
            ),
            MenuItem(
              title: ConstantTexts.seapodsSettings,
              isSelected: tappedMenuIndex == Constants.seapodSettingsViewIndex,
              onTap: () {
                Navigator.of(context).pushNamed(SeapodSettingsPage.routeName);
              },
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
