import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/constants/constant_texts.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/ui/widgets/admin_panel_header.dart';
import 'package:ob_admin_panel/src/ui/widgets/mobile_left_navigation_drawer.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';
import 'package:ob_admin_panel/src/ui/widgets/users_page_widgets/users_table.dart';

class TabletUsersPage extends StatefulWidget {
  @override
  _TabletUsersPageState createState() => _TabletUsersPageState();
}

class _TabletUsersPageState extends State<TabletUsersPage> {
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
            const MobileHeader(),
            const Padding(
              padding: EdgeInsets.all(15),
              child: TabTitle(ConstantTexts.users),
            ),
            Container(
              color: const Color(
                ColorConstants.tabBackground,
              ),
              padding: const EdgeInsets.all(20),
              child: UsersTable(),
            ),
          ],
        ),
      ),
    );
  }
}
