import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/helpers/size_calcs.dart';
import 'package:ob_admin_panel/src/providers/admin_auth_provider.dart';
import 'package:ob_admin_panel/src/ui/pages/desktop_navigation_pages/tabs/access_management.dart';
import 'package:ob_admin_panel/src/ui/pages/desktop_navigation_pages/tabs/devices.dart';
import 'package:ob_admin_panel/src/ui/pages/desktop_navigation_pages/tabs/home.dart';
import 'package:ob_admin_panel/src/ui/pages/desktop_navigation_pages/tabs/locations.dart';
import 'package:ob_admin_panel/src/ui/pages/desktop_navigation_pages/tabs/messages.dart';
import 'package:ob_admin_panel/src/ui/pages/desktop_navigation_pages/tabs/weather.dart';
import 'package:ob_admin_panel/src/ui/pages/home_page.dart';
import 'package:ob_admin_panel/src/ui/pages/login.dart';

import 'package:ob_admin_panel/src/ui/widgets/admin_panel_header.dart';
import 'package:ob_admin_panel/src/ui/widgets/profile_pic.dart';
import 'package:provider/provider.dart';
import 'package:speech_bubble/speech_bubble.dart';

class DesktopHomepage extends StatefulWidget {
  final int seapodsTabIndex;
  final VoidCallback onMapTap;
  final VoidCallback onListTap;
  final bool seapodDetailsPage;
  final bool seapodOwnerScreen;

  DesktopHomepage({
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
  bool _showControlOptions = false;
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    var sizeCalcs = SizeCalcs(context: context);
    final tabViewWidth = sizeCalcs.calculateTabViewWidth();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                        height: Constants.TAB_HEIGHT,
                        width: tabViewWidth,
                        color: Color(
                          ColorConstants.TAB_BACKGROUND,
                        ),
                        child: _buildTabViews()[currentTabIndex],
                      ),
                    ],
                  ),
                  Container(
                    height: Constants.BOTTOM_APP_PADDING_HEIGHT,
                    color: Colors.white,
                  ),
                ],
              ),
              if (_showControlOptions)
                Positioned(
                  right: 60,
                  top: Constants.HEADER_HEIGHT - 10,
                  child: DesktopControlOptions(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTabs() {
    return [
      _AdminPanelTab(
        title: ConstantTexts.HOME,
        isExpanded: currentTabIndex == 0,
        onTap: () {
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        },
      ),
      _AdminPanelTab(
        title: ConstantTexts.WEATHER_MARINE,
        isExpanded: currentTabIndex == 1,
        onTap: () {
          setState(() {
            currentTabIndex = 1;
          });
        },
      ),
      _AdminPanelTab(
        title: ConstantTexts.DEVICES,
        isExpanded: currentTabIndex == 2,
        onTap: () {
          setState(() {
            currentTabIndex = 2;
          });
        },
      ),
      _AdminPanelTab(
        title: ConstantTexts.MESSAGES,
        isExpanded: currentTabIndex == 3,
        onTap: () {
          setState(() {
            currentTabIndex = 3;
          });
        },
      ),
      _AdminPanelTab(
        title: ConstantTexts.ACCESS_MANAGEMENT,
        isExpanded: currentTabIndex == 4,
        onTap: () {
          setState(() {
            currentTabIndex = 4;
          });
        },
      ),
      _AdminPanelTab(
        title: ConstantTexts.LOCATIONS,
        isExpanded: currentTabIndex == 5,
        onTap: () {
          setState(() {
            currentTabIndex = 5;
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
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        color: Color(ColorConstants.LOGIN_REGISTER_TEXT_COLOR),
        nipLocation: NipLocation.TOP_RIGHT,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildControlOption(
              ImagePaths.SETTINGS_ICON,
              ConstantTexts.SETTINGS,
              () {},
            ),
            buildControlOption(
              ImagePaths.PROFILE_ICON,
              ConstantTexts.PROFILE.toUpperCase(),
              () {},
            ),
            buildControlOption(
              ImagePaths.LOGOUT_ICON,
              ConstantTexts.LOGOUT,
              () async {
                await Provider.of<AdminAuthProvider>(context, listen: false)
                    .logout();
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
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
    Function onPressed,
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
            padding: EdgeInsets.only(left: 15),
            child: Text(
              controlOption,
              style: TextStyle(
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
  NavigationMenu({@required this.tabs});
  final List<Widget> tabs;

  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Constants.LEFT_NAVIGATION_WIDTH,
      height: Constants.TAB_HEIGHT,
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(
            height: 18,
          ),
          ...widget.tabs
        ],
      ),
    );
  }
}

class _AdminPanelTab extends StatefulWidget {
  _AdminPanelTab({
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
        padding: EdgeInsets.only(
          left: 15,
          top: 15,
        ),
        color: widget.isExpanded
            ? Color(
                ColorConstants.LOGIN_REGISTER_TEXT_COLOR,
              )
            : Colors.white,
        child: Text(
          widget.title,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: widget.isExpanded
                ? Colors.white
                : Color(
                    ColorConstants.LOGIN_REGISTER_TEXT_COLOR,
                  ),
          ),
        ),
      ),
    );
  }
}
