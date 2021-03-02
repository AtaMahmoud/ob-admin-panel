import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/widgets/admin_panel_header.dart';
import 'package:ob_admin_panel/src/ui/widgets/mobile_left_navigation_drawer.dart';
import 'package:ob_admin_panel/src/ui/widgets/seapod_owner_info_cards.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';
import 'package:provider/provider.dart';

class MobileSeapodOwner extends StatefulWidget {
  @override
  _MobileSeapodOwnerState createState() => _MobileSeapodOwnerState();
}

class _MobileSeapodOwnerState extends State<MobileSeapodOwner> {
  @override
  Widget build(BuildContext context) {
    final selectedOwner =
        Provider.of<SeaPodsProvider>(context, listen: false).selectedOwner;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(
          ColorConstants.tabBackground,
        ),
        drawer: const MobileLeftNavigationMenu(
          tappedMenuIndex: Constants.homeIndex,
        ),
        drawerScrimColor: const Color(ColorConstants.drawerScrimColor),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MobileHeader(
                    showLogo: false,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 20,
                      bottom: 15,
                    ),
                    child: TabTitle(
                      selectedOwner.userName,
                      fontSize: 22,
                    ),
                  ),
                  const ProfileInfoCard(),
                  const ContactsInfoCard(),
                  const ConnectedHomesInfoCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SeapodsOwnerTabletVersion extends StatefulWidget {
  @override
  _SeapodsOwnerTabletVersionState createState() =>
      _SeapodsOwnerTabletVersionState();
}

class _SeapodsOwnerTabletVersionState extends State<SeapodsOwnerTabletVersion> {
  @override
  Widget build(BuildContext context) {
    final selectedOwner =
        Provider.of<SeaPodsProvider>(context, listen: false).selectedOwner;
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide < 900
        ? MobileSeapodOwner()
        : SafeArea(
            child: Scaffold(
              backgroundColor: const Color(
                ColorConstants.tabBackground,
              ),
              drawer: const MobileLeftNavigationMenu(
                tappedMenuIndex: 0,
              ),
              drawerScrimColor: const Color(ColorConstants.drawerScrimColor),
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MobileHeader(
                          showLogo: false,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            left: 20,
                            bottom: 15,
                          ),
                          child: TabTitle(
                            selectedOwner.userName,
                            fontSize: 22,
                          ),
                        ),
                        Row(
                          children: const [
                            Expanded(
                              child: ProfileInfoCard(),
                            ),
                            Expanded(
                              child: ContactsInfoCard(),
                            ),
                            Expanded(
                              child: ConnectedHomesInfoCard(),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
