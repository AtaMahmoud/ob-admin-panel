import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/widgets/desktop_main_view.dart';
import 'package:ob_admin_panel/src/ui/widgets/seapod_locations_cards.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';
import 'package:provider/provider.dart';

class DesktopSeapodLocationsPage extends StatefulWidget {
  @override
  _DesktopSeapodLocationsPageState createState() =>
      _DesktopSeapodLocationsPageState();
}

class _DesktopSeapodLocationsPageState
    extends State<DesktopSeapodLocationsPage> {
  @override
  Widget build(BuildContext context) {
    const textStyle1 = TextStyle(
      color: Color(ColorConstants.mainColor),
      fontSize: 13,
    );
    final selectedSeapod =
        Provider.of<SeaPodsProvider>(context, listen: false).selectedSeapod;
    return DesktopMainView(
      selectedSeapodName: selectedSeapod.seaPodName,
      viewIndex: Constants.homeIndex,
      view: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          top: 25,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabTitle(
              selectedSeapod.seaPodName,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 30),
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
                  width: 1088,
                  height: 352,
                  child: SeapodLocationsCards(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
