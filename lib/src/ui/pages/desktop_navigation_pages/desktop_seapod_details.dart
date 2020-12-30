import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/widgets/seapod_info_cards.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';
import 'package:provider/provider.dart';

class DesktopSeapodDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _selectedSeapod = Provider.of<SeaPodsProvider>(context).selectedSeapod;
    var textStyle1 = TextStyle(
      color: Color(ColorConstants.MAIN_COLOR),
      fontSize: 10,
    );
    var pixelRatio = MediaQuery.of(context).devicePixelRatio;
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        top: 25,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabTitle(
            ConstantTexts.ABOUT,
            fontSize: 22,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: [
                Text(
                  ConstantTexts.OWNERSHIP,
                  style: textStyle1,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  ConstantTexts.DEVICES,
                  style: textStyle1,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(),
              ),
              Column(
                children: [
                  Container(
                    width: 416 * pixelRatio,
                    child: GeneralInfoCard(),
                  ),
                  Container(
                    width: 416,
                    child: LocationInfoCard(),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
