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
import 'package:ob_admin_panel/src/ui/pages/login.dart';
import 'package:ob_admin_panel/src/ui/widgets/admin_panel_header.dart';
import 'package:ob_admin_panel/src/ui/widgets/profile_pic.dart';
import 'package:provider/provider.dart';
import 'package:speech_bubble/speech_bubble.dart';

class DesktopHomepage extends StatefulWidget {
  final int tabIndex;
  final VoidCallback onMapTap;
  final VoidCallback onListTap;
  final int homeIndex;

  DesktopHomepage({
    @required this.tabIndex,
    @required this.onMapTap,
    @required this.onListTap,
    @required this.homeIndex,
  });

  @override
  _DesktopHomepageState createState() => _DesktopHomepageState();
}

class _DesktopHomepageState extends State<DesktopHomepage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool _showControlOptions = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: Constants.TAB_COUNT, vsync: this)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final verticalRotation = Constants.TURNS_TO_ROTATE_RIGHT;
    final revertVerticalRotation = Constants.TURNS_TO_ROTATE_LEFT;
    var sizeCalcs = SizeCalcs(context: context);
    final tabViewHeight = sizeCalcs.calculateTabViewHeight();
    final tabViewWidth = sizeCalcs.calculateTabViewWidth();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                Expanded(
                  child: Row(
                    children: [
                      NavigationMenu(
                        verticalRotation: verticalRotation,
                        revertVerticalRotation: revertVerticalRotation,
                        tabController: _tabController,
                      ),
                      RotatedBox(
                        quarterTurns: verticalRotation,
                        child: Container(
                          height: tabViewHeight,
                          width: tabViewWidth,
                          child: TabBarView(
                            controller: _tabController,
                            children: _buildTabViews().map(
                              (widget) {
                                // Revert the rotation on the tab views.
                                return Container(
                                  color: Color(
                                    ColorConstants.TAB_BACKGROUND,
                                  ),
                                  child: RotatedBox(
                                    quarterTurns:
                                        Constants.TURNS_TO_ROTATE_LEFT,
                                    child: widget,
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
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
    );
  }

  List<Widget> _buildTabViews() {
    return [
      HomeView(
        tabIndex: widget.tabIndex,
        onListTap: widget.onListTap,
        onMapTap: widget.onMapTap,
        homeIndex: widget.homeIndex,
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
        height: 160,
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
              ImagePaths.SEAPOD_ICON,
              ConstantTexts.ADD_NEW_SEAPOD,
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

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({
    Key key,
    @required this.verticalRotation,
    @required this.revertVerticalRotation,
    @required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final int verticalRotation;
  final int revertVerticalRotation;
  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Constants.LEFT_NAVIGATION_WIDTH,
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(
            height: 18,
          ),
          RotatedBox(
            quarterTurns: verticalRotation,
            child: _TabBar(
              tabs: _buildTabs().map(
                (widget) {
                  // Revert the rotation on the tabs.
                  return RotatedBox(
                    quarterTurns: revertVerticalRotation,
                    child: widget,
                  );
                },
              ).toList(),
              tabController: _tabController,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTabs() {
    return [
      _AdminPanelTab(
        title: ConstantTexts.HOME,
        tabIndex: 0,
        tabController: _tabController,
      ),
      _AdminPanelTab(
        title: ConstantTexts.WEATHER_MARINE,
        tabIndex: 1,
        tabController: _tabController,
      ),
      _AdminPanelTab(
        title: ConstantTexts.DEVICES,
        tabIndex: 2,
        tabController: _tabController,
      ),
      _AdminPanelTab(
        title: ConstantTexts.MESSAGES,
        tabIndex: 3,
        tabController: _tabController,
      ),
      _AdminPanelTab(
        title: ConstantTexts.ACCESS_MANAGEMENT,
        tabIndex: 4,
        tabController: _tabController,
      ),
      _AdminPanelTab(
        title: ConstantTexts.LOCATIONS,
        tabIndex: 5,
        tabController: _tabController,
      ),
    ];
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar({Key key, this.tabs, this.tabController}) : super(key: key);

  final List<Widget> tabs;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(ColorConstants.MAIN_COLOR),
      child: TabBar(
        isScrollable: true,
        labelPadding: EdgeInsets.zero,
        tabs: tabs,
        controller: tabController,
        indicatorColor: Colors.transparent,
      ),
    );
  }
}

class _AdminPanelTab extends StatefulWidget {
  _AdminPanelTab({
    this.title,
    int tabIndex,
    TabController tabController,
  }) : isExpanded = tabController.index == tabIndex;

  final String title;

  final bool isExpanded;

  @override
  _AdminPanelTabState createState() => _AdminPanelTabState();
}

class _AdminPanelTabState extends State<_AdminPanelTab>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 180,
      padding: EdgeInsets.only(
        left: 15,
        top: 10,
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
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: widget.isExpanded
              ? Colors.white
              : Color(
                  ColorConstants.LOGIN_REGISTER_TEXT_COLOR,
                ),
        ),
      ),
    );
  }
}
