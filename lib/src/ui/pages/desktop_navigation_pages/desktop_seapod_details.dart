import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/helpers/size_calcs.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/widgets/seapod_info_cards.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';
import 'package:provider/provider.dart';

class DesktopSeapodDetails extends StatefulWidget {
  @override
  _DesktopSeapodDetailsState createState() => _DesktopSeapodDetailsState();
}

class _DesktopSeapodDetailsState extends State<DesktopSeapodDetails> {
  SeaPodsProvider seaPodsProvider;
  var _isInit = true;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      seaPodsProvider = Provider.of<SeaPodsProvider>(
        context,
        listen: false,
      );
      await seaPodsProvider.getSeapodOwners();
      setState(() {});
      _isInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var _selectedSeapod = Provider.of<SeaPodsProvider>(context).selectedSeapod;
    var textStyle1 = TextStyle(
      color: Color(ColorConstants.MAIN_COLOR),
      fontSize: 12,
    );
    var sizeCalcs = SizeCalcs(context: context);
    final tabViewWidth = sizeCalcs.calculateTabViewWidth();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          top: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabTitle(
              ConstantTexts.ABOUT,
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
            if (!_isInit)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: const EdgeInsets.only(top: 20),
                  width: tabViewWidth > 2000 ? 1800 : 1400,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          buildSeapodInfoContainer(
                            ConstantTexts.VESSLE_NAME,
                            _selectedSeapod.seaPodName,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          buildSeapodInfoContainer(
                            ConstantTexts.CURRENT_OCCUPANT,
                            _selectedSeapod.ownersNames[0],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 416,
                            child: GeneralInfoCard(
                              isDesktop: true,
                            ),
                          ),
                          Container(
                            width: 416,
                            child: LocationInfoCard(),
                          ),
                          ...[
                            for (var owner in _selectedSeapod.owners) ...[
                              Container(
                                width: 416,
                                child: OwnerInfoCard(
                                  owner: owner,
                                ),
                              ),
                            ]
                          ]
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  buildSeapodInfoContainer(
    String infoTitle,
    String info,
  ) {
    return Container(
      width: 500,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            infoTitle,
            style: TextStyle(
              color: Color(ColorConstants.TEXT_COLOR),
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          Container(
            height: 40,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 10),
            width: 350,
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: const Color(
                      ColorConstants.TEXT_FIELD_BORDER,
                    ),
                  ),
                ),
              ),
              child: Text(
                info,
                style: TextStyle(
                  color: Color(
                    ColorConstants.LOGIN_REGISTER_TEXT_COLOR,
                  ),
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
