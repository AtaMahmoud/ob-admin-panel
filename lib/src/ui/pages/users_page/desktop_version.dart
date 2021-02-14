import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/ui/widgets/desktop_main_view.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';
import 'package:ob_admin_panel/src/ui/widgets/users_table.dart';

class DesktopUsersPage extends StatefulWidget {
  @override
  _DesktopLocationsPageState createState() => _DesktopLocationsPageState();
}

class _DesktopLocationsPageState extends State<DesktopUsersPage> {
 
  @override
  Widget build(BuildContext context) {
    return DesktopMainView(
      viewIndex: Constants.usersViewIndex,
      view: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 35,
          top: 25,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 50,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TabTitle(
                    ConstantTexts.users,
                  ),
                  Image.asset(
                    ImagePaths.tableFilterIcon,
                  )
                ],
              ),
            ),
           UsersTable(),
          ],
        ),
      ),
    );
  }

 
}
