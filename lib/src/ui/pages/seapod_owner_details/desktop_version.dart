import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/widgets/desktop_main_view.dart';
import 'package:ob_admin_panel/src/ui/widgets/seapod_owner_info_cards.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';
import 'package:provider/provider.dart';

class DesktopSeapodOwner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectedOwner =
        Provider.of<SeaPodsProvider>(context, listen: false).selectedOwner;
    return DesktopMainView(
      viewIndex: Constants.homeIndex,
      view: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabTitle(selectedOwner.userName),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 376,
                        child: ProfileInfoCard(),
                      ),
                      SizedBox(
                        width: 376,
                        child: ContactsInfoCard(),
                      ),
                      SizedBox(
                        width: 376,
                        child: ConnectedHomesInfoCard(),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
