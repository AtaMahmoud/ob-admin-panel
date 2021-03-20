import 'package:flutter/material.dart';
//import 'package:flutter_web_scrollbar/flutter_web_scrollbar.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/constants/constant_texts.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/constants/image_paths.dart';
import 'package:ob_admin_panel/src/models/seapod.dart';
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
import 'package:ob_admin_panel/src/ui/widgets/admin_panel_header.dart';
import 'package:ob_admin_panel/src/ui/widgets/profile_pic.dart';
import 'package:provider/provider.dart';
import 'package:speech_bubble/speech_bubble.dart';

class DesktopMainView extends StatefulWidget {
  final Widget view;
  final int viewIndex;
  final String selectedSeapodName;

  const DesktopMainView({
    @required this.view,
    @required this.viewIndex,
    this.selectedSeapodName,
  });

  @override
  _DesktopHomepageState createState() => _DesktopHomepageState();
}

class _DesktopHomepageState extends State<DesktopMainView> {
  ScrollController _controller;
  bool _showControlOptions = false;
  SeaPod selectedSeapod;

  void scrollCallBack(DragUpdateDetails dragUpdate) {
    setState(() {
      _controller.position.moveTo(dragUpdate.globalPosition.dy * 1.5);
    });
  }

  @override
  Widget build(BuildContext context) {
    selectedSeapod = Provider.of<SeaPodsProvider>(context).selectedSeapod;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              controller: _controller,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DesktopHeader(
                        onTap: () {
                          setState(() {
                            _showControlOptions = !_showControlOptions;
                          });
                        },
                        selectedSeapodName: widget.selectedSeapodName,
                      ),
                      Row(
                        children: [
                          NavigationMenu(
                            tabs: _buildTabs(),
                          ),
                          Expanded(
                            child: Container(
                              height: Constants.tabHeight,
                              color: const Color(
                                ColorConstants.tabBackground,
                              ),
                              child: widget.view,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: Constants.bottomAppPadding,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  if (_showControlOptions)
                    const Positioned(
                      right: 60,
                      top: Constants.headerHeight - 10,
                      child: DesktopControlOptions(),
                    ),
                ],
              ),
            ),
          ),
          /*  FlutterWebScroller(
            scrollCallBack,
            scrollBarBackgroundColor: Colors.white,
            dragHandleColor: const Color(ColorConstants.scrollBarColor),
            dragHandleHeight: 65.0,
            dragHandleWidth: 5.0,
          ), */
        ],
      ),
    );
  }

  List<Widget> _buildTabs() {
    final homeTab = _AdminPanelTab(
      titleColor: selectedSeapod == null
          ? const Color(
              ColorConstants.loginRegisterTextColor,
            )
          : const Color(ColorConstants.mainColor),
      title: selectedSeapod != null
          ? selectedSeapod.seaPodName
          : ConstantTexts.home,
      isSelected: widget.viewIndex == Constants.homeIndex,
      onTap: () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, _, __) => SeapodsPage(),
            transitionDuration: const Duration(),
            settings: const RouteSettings(name: SeapodsPage.routeName),
          ),
        );
      },
    );

    final usersTab = _AdminPanelTab(
      title: ConstantTexts.users.toUpperCase(),
      isSelected: widget.viewIndex == Constants.usersViewIndex,
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, _, __) => UsersPage(),
            transitionDuration: const Duration(),
            settings: const RouteSettings(name: UsersPage.routeName),
          ),
        );
      },
    );
    return selectedSeapod == null
        ? [
            homeTab,
            usersTab,
          ]
        : [
            homeTab,
            _AdminPanelTab(
              title: ConstantTexts.weatherMarine,
              isSelected: widget.viewIndex == Constants.weatherViewIndex,
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, _, __) => WeatherPage(),
                    transitionDuration: const Duration(),
                    settings: const RouteSettings(name: WeatherPage.routeName),
                  ),
                );
              },
            ),
            _AdminPanelTab(
              title: ConstantTexts.devices.toUpperCase(),
              isSelected: widget.viewIndex == Constants.devicesViewIndex,
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, _, __) => DevicesPage(),
                    transitionDuration: const Duration(),
                    settings: const RouteSettings(name: DevicesPage.routeName),
                  ),
                );
              },
            ),
            _AdminPanelTab(
              title: ConstantTexts.messages,
              isSelected: widget.viewIndex == Constants.messagesViewIndex,
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, _, __) => MessagesPage(),
                    transitionDuration: const Duration(),
                    settings: const RouteSettings(name: MessagesPage.routeName),
                  ),
                );
              },
            ),
            _AdminPanelTab(
              title: ConstantTexts.acceseManagement,
              isSelected: widget.viewIndex == Constants.accessManagementIndex,
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, _, __) => AccessManagementPage(),
                    transitionDuration: const Duration(),
                    settings: const RouteSettings(
                        name: AccessManagementPage.routeName),
                  ),
                );
              },
            ),
            _AdminPanelTab(
              title: ConstantTexts.locations,
              isSelected: widget.viewIndex == Constants.locationsViewIndex,
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, _, __) => LocationsPage(),
                    transitionDuration: const Duration(),
                    settings:
                        const RouteSettings(name: LocationsPage.routeName),
                  ),
                );
              },
            ),
            _AdminPanelTab(
              title: ConstantTexts.seapodsSettings,
              isSelected: widget.viewIndex == Constants.seapodSettingsViewIndex,
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, _, __) => SeapodSettingsPage(),
                    transitionDuration: const Duration(),
                    settings:
                        const RouteSettings(name: SeapodSettingsPage.routeName),
                  ),
                );
              },
            ),
          ];
  }
}

class DesktopControlOptions extends StatelessWidget {
  const DesktopControlOptions({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpeechBubble(
        nipHeight: 15,
        height: 128,
        width: 210,
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        color: const Color(ColorConstants.loginRegisterTextColor),
        nipLocation: NipLocation.TOP_RIGHT,
        offset: const Offset(-25.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildControlOption(
              ImagePaths.settingsIcon,
              ConstantTexts.settings,
              () {},
            ),
            buildControlOption(
              ImagePaths.profileIcon,
              ConstantTexts.profile.toUpperCase(),
              () {},
            ),
            buildControlOption(
              ImagePaths.logoutIcon,
              ConstantTexts.logout,
              () async {
                await Provider.of<AdminAuthProvider>(context, listen: false)
                    .logout();

                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        LoginPage(),
                    transitionDuration: const Duration(),
                    settings: const RouteSettings(name: LoginPage.routeName),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildControlOption(
    String iconPath,
    String controlOption,
    void Function() onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Image.asset(
              iconPath,
              fit: BoxFit.contain,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              controlOption,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({@required this.tabs});
  final List<Widget> tabs;

  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Constants.leftNavigationWidth,
      height: Constants.tabHeight,
      child: Column(
        children: [
          ProfilePic(),
          const SizedBox(
            height: 18,
          ),
          ...widget.tabs
        ],
      ),
    );
  }
}

class _AdminPanelTab extends StatefulWidget {
  const _AdminPanelTab({
    this.title,
    this.isSelected,
    this.onTap,
    this.titleColor = const Color(
      ColorConstants.loginRegisterTextColor,
    ),
  });

  final String title;

  final bool isSelected;
  final VoidCallback onTap;
  final Color titleColor;

  @override
  _AdminPanelTabState createState() => _AdminPanelTabState();
}

class _AdminPanelTabState extends State<_AdminPanelTab> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 45,
        width: 200,
        padding: const EdgeInsets.only(
          left: 15,
          top: 15,
        ),
        color: widget.isSelected
            ? const Color(
                ColorConstants.loginRegisterTextColor,
              )
            : Colors.white,
        child: Text(
          widget.title,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: widget.isSelected ? Colors.white : widget.titleColor,
          ),
        ),
      ),
    );
  }
}
