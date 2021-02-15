import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/widgets/admin_panel_header.dart';
import 'package:ob_admin_panel/src/ui/widgets/mobile_left_navigation_drawer.dart';
import 'package:ob_admin_panel/src/ui/widgets/seapod_locations_cards.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';
import 'package:provider/provider.dart';

class MobileSeapodLocationsPage extends StatefulWidget {
  @override
  _MobileSeapodLocationsPageState createState() =>
      _MobileSeapodLocationsPageState();
}

class _MobileSeapodLocationsPageState extends State<MobileSeapodLocationsPage> {
  @override
  Widget build(BuildContext context) {
    const textStyle1 = TextStyle(
      color: Color(ColorConstants.mainColor),
      fontSize: 13,
    );
    final selectedSeapod = Provider.of<SeaPodsProvider>(
      context,
      listen: false,
    ).selectedSeapod;
    return Scaffold(
      backgroundColor: const Color(
        ColorConstants.tabBackground,
      ),
      drawer: const MobileLeftNavigationMenu(
        tappedMenuIndex: Constants.homeIndex,
      ),
      drawerScrimColor: const Color(ColorConstants.drawerScrimColor),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MobileHeader(),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                bottom: 15,
              ),
              child: TabTitle(
                selectedSeapod.seaPodName,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20),
              child: Text(
                '${ConstantTexts.seapod.toUpperCase()}  /  ${selectedSeapod.seaPodName}  /  ${ConstantTexts.locations}'
                    .toUpperCase(),
                style: textStyle1,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 720,
                  height: 530,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: SeapodLocationsCards(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
