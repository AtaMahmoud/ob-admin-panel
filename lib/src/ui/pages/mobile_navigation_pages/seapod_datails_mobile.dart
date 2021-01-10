import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/widgets/admin_panel_header.dart';
import 'package:ob_admin_panel/src/ui/widgets/mobile_left_navigation_drawer.dart';
import 'package:ob_admin_panel/src/ui/widgets/seapod_info_cards.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';
import 'package:provider/provider.dart';

class MobileSeapodDetails extends StatefulWidget {
  @override
  _MobileSeapodDetailsState createState() => _MobileSeapodDetailsState();
}

class _MobileSeapodDetailsState extends State<MobileSeapodDetails> {
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
    var textStyle1 = TextStyle(
      color: Color(ColorConstants.MAIN_COLOR),
    );

    var _selectedSeapod = seaPodsProvider.selectedSeapod;

    return Scaffold(
      backgroundColor: Color(
        ColorConstants.TAB_BACKGROUND,
      ),
      drawer: MobileLeftNavigationMenu(
        tappedMenuIndex: 0,
      ),
      drawerScrimColor: Color(ColorConstants.DRAWER_SCRIM_COLOR),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
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
                        ConstantTexts.GENERAL_INFO,
                        fontSize: 22,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 20),
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
                  ],
                ),
              ),
            ),
            if (_isInit)
              SliverToBoxAdapter(
                child: Container(
                  height: 300,
                  child: SpinKitFadingCircle(
                    color: Color(ColorConstants.MAIN_COLOR),
                    size: 50,
                  ),
                ),
              ),
            if (!_isInit)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Column(
                    children: [
                      buildSeapodInfoContainer(
                        ConstantTexts.VESSLE_NAME,
                        _selectedSeapod.seaPodName,
                      ),
                      buildSeapodInfoContainer(
                        ConstantTexts.CURRENT_OCCUPANT,
                        _selectedSeapod.ownersNames[0],
                      ),
                    ],
                  ),
                ),
              ),
            if (!_isInit)
              SliverToBoxAdapter(
                child: GeneralInfoCard(),
              ),
            if (!_isInit)
              SliverToBoxAdapter(
                child: LocationInfoCard(),
              ),
            if (!_isInit) ...[
              for (var owner in _selectedSeapod.owners) ...[
                SliverToBoxAdapter(
                  child: OwnerInfoCard(
                    owner: owner,
                  ),
                ),
              ]
            ]
          ],
        ),
      ),
    );
  }

  Container buildSeapodInfoContainer(
    String infoTitle,
    String info,
  ) {
    return Container(
      padding: const EdgeInsets.only(
        top: 30,
        left: 15,
        right: 15,
      ),
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Text(
              infoTitle,
              style: TextStyle(
                color: Color(ColorConstants.TEXT_COLOR),
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
          Container(
            height: 40,
            alignment: Alignment.centerLeft,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
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
        ],
      ),
    );
  }
}
