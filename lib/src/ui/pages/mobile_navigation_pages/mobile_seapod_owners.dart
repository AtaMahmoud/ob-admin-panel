import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/widgets/admin_panel_header.dart';
import 'package:ob_admin_panel/src/ui/widgets/mobile_left_navigation_drawer.dart';
import 'package:ob_admin_panel/src/ui/widgets/seapod_owner_info_cards.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MobileSeapodOwner extends StatefulWidget {
  @override
  _MobileSeapodOwnerState createState() => _MobileSeapodOwnerState();
}

class _MobileSeapodOwnerState extends State<MobileSeapodOwner> {
  @override
  Widget build(BuildContext context) {
    var selectedOwner =
        Provider.of<SeaPodsProvider>(context, listen: false).selectedOwner;
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Color(
              ColorConstants.TAB_BACKGROUND,
            ),
            drawer: MobileLeftNavigationMenu(
              tappedMenuIndex: 0,
            ),
            drawerScrimColor: Color(ColorConstants.DRAWER_SCRIM_COLOR),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MobileHeader(
                        showLogo: false,
                      ),
                      SizedBox(
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
                      if (sizingInformation.deviceScreenType ==
                          DeviceScreenType.mobile)
                        ProfileInfoCard(),
                      if (sizingInformation.deviceScreenType ==
                          DeviceScreenType.mobile)
                        ContactsInfoCard(),
                      if (sizingInformation.deviceScreenType ==
                          DeviceScreenType.mobile)
                        ConnectedHomesInfoCard(),
                      if (sizingInformation.deviceScreenType ==
                          DeviceScreenType.tablet)
                        Row(
                          children: [
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
      },
    );
  }
}
