import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/helpers/size_calcs.dart';
import 'package:ob_admin_panel/src/providers/admin_auth_provider.dart';
import 'package:ob_admin_panel/src/ui/pages/desktop_navigation_pages/tabs/access_management.dart';
import 'package:ob_admin_panel/src/ui/pages/desktop_navigation_pages/tabs/devices.dart';
import 'package:ob_admin_panel/src/ui/pages/desktop_navigation_pages/tabs/home.dart';
import 'package:ob_admin_panel/src/ui/pages/desktop_navigation_pages/tabs/locations.dart';
import 'package:ob_admin_panel/src/ui/pages/desktop_navigation_pages/tabs/messages.dart';
import 'package:ob_admin_panel/src/ui/pages/desktop_navigation_pages/tabs/seapod_settings.dart';
import 'package:ob_admin_panel/src/ui/pages/desktop_navigation_pages/tabs/users.dart';
import 'package:ob_admin_panel/src/ui/pages/desktop_navigation_pages/tabs/weather.dart';
import 'package:ob_admin_panel/src/ui/pages/home_page.dart';
import 'package:ob_admin_panel/src/ui/pages/login.dart';

import 'package:ob_admin_panel/src/ui/widgets/admin_panel_header.dart';
import 'package:ob_admin_panel/src/ui/widgets/profile_pic.dart';
import 'package:provider/provider.dart';
import 'package:speech_bubble/speech_bubble.dart';
import 'package:flutter_web_scrollbar/flutter_web_scrollbar.dart';

class DesktopHomepage extends StatefulWidget {
  final int seapodsTabIndex;
  final VoidCallback onMapTap;
  final VoidCallback onListTap;
  final bool seapodDetailsPage;
  final bool seapodOwnerScreen;

  const DesktopHomepage({
    @required this.seapodsTabIndex,
    @required this.onMapTap,
    @required this.onListTap,
    @required this.seapodDetailsPage,
    @required this.seapodOwnerScreen,
  });

  @override
  _DesktopHomepageState createState() => _DesktopHomepageState();
}

class _DesktopHomepageState extends State<DesktopHomepage> {
  ScrollController _controller;
  bool _showControlOptions = false;
  int currentTabIndex = 0;

  void scrollCallBack(DragUpdateDetails dragUpdate) {
    setState(() {
      _controller.position.moveTo(dragUpdate.globalPosition.dy * 1.5);
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeCalcs = SizeCalcs(context: context);
    final tabViewWidth = sizeCalcs.calculateTabViewWidth();

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
                        showControlOptions: () {
                          setState(() {
                            _showControlOptions = !_showControlOptions;
                          });
                        },
                      ),
                      Row(
                        children: [
                          NavigationMenu(
                            tabs: _buildTabs(),
                          ),
                          Container(
                            height: Constants.tabHeight,
                            width: tabViewWidth,
                            color: const Color(
                              ColorConstants.tabBackground,
                            ),
                            child: _buildTabViews()[currentTabIndex],
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
          FlutterWebScroller(
            scrollCallBack,
            scrollBarBackgroundColor: Colors.white,
            dragHandleColor: const Color(ColorConstants.scrollBarColor),
            dragHandleHeight: 65.0,
            dragHandleWidth: 5.0,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTabs() {
    return [
      _AdminPanelTab(
        title: ConstantTexts.home,
        isExpanded: currentTabIndex == 0,
        onTap: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => const HomePage(),
              transitionDuration: const Duration(),
              settings: const RouteSettings(name: HomePage.routeName),
            ),
          );
        },
      ),
      _AdminPanelTab(
        title: ConstantTexts.weatherMarine,
        isExpanded: currentTabIndex == 1,
        onTap: () {
          setState(() {
            currentTabIndex = 1;
          });
        },
      ),
      _AdminPanelTab(
        title: ConstantTexts.devices,
        isExpanded: currentTabIndex == 2,
        onTap: () {
          setState(() {
            currentTabIndex = 2;
          });
        },
      ),
      _AdminPanelTab(
        title: ConstantTexts.messages,
        isExpanded: currentTabIndex == 3,
        onTap: () {
          setState(() {
            currentTabIndex = 3;
          });
        },
      ),
      _AdminPanelTab(
        title: ConstantTexts.acceseManagement,
        isExpanded: currentTabIndex == 4,
        onTap: () {
          setState(() {
            currentTabIndex = 4;
          });
        },
      ),
      _AdminPanelTab(
        title: ConstantTexts.locations,
        isExpanded: currentTabIndex == 5,
        onTap: () {
          setState(() {
            currentTabIndex = 5;
          });
        },
      ),
      _AdminPanelTab(
        title: ConstantTexts.users,
        isExpanded: currentTabIndex == 6,
        onTap: () {
          setState(() {
            currentTabIndex = 6;
          });
        },
      ),
      _AdminPanelTab(
        title: ConstantTexts.seapodsSettings,
        isExpanded: currentTabIndex == 7,
        onTap: () {
          setState(() {
            currentTabIndex = 7;
          });
        },
      ),
    ];
  }

  List<Widget> _buildTabViews() {
    return [
      HomeView(
        seapodsTabIndex: widget.seapodsTabIndex,
        onListTap: widget.onListTap,
        onMapTap: widget.onMapTap,
        seapodOwnerScreen: widget.seapodOwnerScreen,
        seapodDetailsPage: widget.seapodDetailsPage,
      ),
      WeatherView(),
      DevicesView(),
      MessagesView(),
      AccessManagementView(),
      LocationsView(),
      Users(),
      SeapodSettings(),
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
    this.isExpanded,
    this.onTap,
  });

  final String title;

  final bool isExpanded;
  final VoidCallback onTap;

  @override
  _AdminPanelTabState createState() => _AdminPanelTabState();
}

class _AdminPanelTabState extends State<_AdminPanelTab>
    with SingleTickerProviderStateMixin {
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
        color: widget.isExpanded
            ? const Color(
                ColorConstants.loginRegisterTextColor,
              )
            :  Colors.white,
        child: Text(
          widget.title,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: widget.isExpanded
                ? Colors.white
                : const Color(
                    ColorConstants.loginRegisterTextColor,
                  ),
          ),
        ),
      ),
    );
  }
}
