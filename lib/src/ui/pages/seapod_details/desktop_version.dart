import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/helpers/size_calcs.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/widgets/desktop_main_view.dart';
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
  var _isLoading = false;

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      seaPodsProvider = Provider.of<SeaPodsProvider>(
        context,
        listen: false,
      );
      await seaPodsProvider.getSeapodOwners();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _selectedSeapod =
        Provider.of<SeaPodsProvider>(context).selectedSeapod;
    const textStyle1 = TextStyle(
      color: Color(ColorConstants.mainColor),
      fontSize: 12,
    );
    final sizeCalcs = SizeCalcs(context: context);
    final tabViewWidth = sizeCalcs.calculateTabViewWidth();

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
              const TabTitle(
                ConstantTexts.about,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: const [
                    Text(
                      ConstantTexts.ownership,
                      style: textStyle1,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      ConstantTexts.devices,
                      style: textStyle1,
                    ),
                  ],
                ),
              ),
              if (!_isLoading)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    padding: const EdgeInsets.only(top: 20, right: 50),
                    width: tabViewWidth,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            buildSeapodInfoContainer(
                              ConstantTexts.vessleName,
                              _selectedSeapod.seaPodName,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            buildSeapodInfoContainer(
                              ConstantTexts.currentOccupant,
                              _selectedSeapod.ownersNames[0],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              width: 416,
                              child: GeneralInfoCard(
                                isDesktop: true,
                              ),
                            ),
                            const SizedBox(
                              width: 416,
                              child: LocationInfoCard(),
                            ),
                            ...[
                              for (var owner in _selectedSeapod.owners) ...[
                                SizedBox(
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
      ),
    );
  }

  Widget buildSeapodInfoContainer(
    String infoTitle,
    String info,
  ) {
    return SizedBox(
      width: 500,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            infoTitle,
            style: const TextStyle(
              color: Color(ColorConstants.textColor),
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          Container(
            height: 40,
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 10),
            width: 350,
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Color(
                      ColorConstants.textFieldBorder,
                    ),
                  ),
                ),
              ),
              child: Text(
                info,
                style: const TextStyle(
                  color: Color(
                    ColorConstants.loginRegisterTextColor,
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
