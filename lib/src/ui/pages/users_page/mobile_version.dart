import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/models/seapod.dart';
import 'package:ob_admin_panel/src/ui/widgets/admin_panel_header.dart';
import 'package:ob_admin_panel/src/ui/widgets/mobile_left_navigation_drawer.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';
import 'package:ob_admin_panel/src/ui/widgets/user_info_bubble.dart';

class MobileUsersPage extends StatefulWidget {
  @override
  _MobileLocationsPageState createState() => _MobileLocationsPageState();
}

class _MobileLocationsPageState extends State<MobileUsersPage> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MobileLeftNavigationMenu(
        tappedMenuIndex: Constants.usersViewIndex,
      ),
      drawerScrimColor: const Color(ColorConstants.drawerScrimColor),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MobileHeader(
              showLogo: false,
              showFilterIcon: true,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: TabTitle(ConstantTexts.users),
            ),
            Expanded(
              child: Container(
                color: const Color(
                  ColorConstants.tabBackground,
                ),
                padding: const EdgeInsets.only(top: 10.0),
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? Colors.white
                            : const Color(ColorConstants.usersCardBackground),
                        border: Border.all(
                          color: const Color(
                            ColorConstants.tableViewTextColor,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: onUserCardTap,
                            child: Column(
                              children: [
                                buildUserCardInfo(),
                                if (isExpanded)
                                  Column(
                                    children: [
                                      Container(
                                        height: 1,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 15.0,
                                        ),
                                        color: const Color(0xFFC6D0DB),
                                      ),
                                      buildUserCardInfo(
                                        showUserName: false,
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Icon(
                                  isExpanded
                                      ? Icons.arrow_drop_up
                                      : Icons.arrow_drop_down,
                                  size: 40.0,
                                  color: const Color(
                                    ColorConstants.tableViewTextColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildUserCardInfo({
    bool showUserName = true,
  }) {
    const sizedBox = SizedBox(
      height: 18.0,
    );
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showUserName)
            userInfoRow(
              ConstantTexts.name,
              'Grant Romundt',
              contentColor: const Color(
                ColorConstants.mainColor,
              ),
            ),
          if (showUserName) sizedBox,
          seapodRow(
            'Second Wind',
            'Private',
          ),
          sizedBox,
          userInfoRow(
            ConstantTexts.memberSince,
            '01/01/2020',
          ),
          sizedBox,
          userInfoRow(
            ConstantTexts.type,
            'Owner',
          ),
          sizedBox,
          userInfoRow(
            ConstantTexts.access,
            'Property Manager',
          ),
          sizedBox,
          locationRow(
            Location(
              locationName: 'Panama',
              latitude: 2.0121545,
              longitude: 2.012015,
            ),
          )
        ],
      ),
    );
  }

  Widget locationRow(Location location) {
    const sizedBox = SizedBox(
      height: 10,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          child: userInfoText(
            ConstantTexts.location,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              userInfoText(
                location.locationName,
                fontSize: 14.0,
              ),
              sizedBox,
              userInfoText(
                ConstantTexts.latitude + location.latitude.toString(),
                fontSize: 14.0,
              ),
              sizedBox,
              userInfoText(
                  ConstantTexts.longitude + location.longitude.toString()),
            ],
          ),
        )
      ],
    );
  }

  Widget seapodRow(
    String seapodName,
    String seapodType,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          child: userInfoText(
            ConstantTexts.seapod,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              userInfoText(
                seapodName,
                color: const Color(
                  ColorConstants.mainColor,
                ),
                fontSize: 14.0,
              ),
              userInfoText(
                seapodType,
                fontSize: 14.0,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget userInfoRow(
    String infoTitle,
    String infoContent, {
    Color contentColor,
  }) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          child: userInfoText(
            infoTitle,
          ),
        ),
        Expanded(
          child: userInfoText(
            infoContent,
            color: contentColor,
            fontSize: 14.0,
          ),
        )
      ],
    );
  }

  Widget userInfoText(
    String text, {
    Color color,
    double fontSize,
  }) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontSize: fontSize ?? 15,
        fontWeight: FontWeight.w600,
        color: color ??
            const Color(
              ColorConstants.textColor,
            ),
      ),
    );
  }

  void onUserCardTap() {
    showDialog(
      barrierColor: const Color(ColorConstants.drawerScrimColor),
      context: context,
      builder: (
        context,
      ) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
          child: Dialog(
            backgroundColor: const Color(ColorConstants.loginRegisterTextColor)
                .withOpacity(0.8),
            child: Container(
              height: 470.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
              ),
              padding: const EdgeInsets.only(top: 20.0),
              child: const UserInfoList(),
            ),
          ),
        );
      },
    );
  }
}
