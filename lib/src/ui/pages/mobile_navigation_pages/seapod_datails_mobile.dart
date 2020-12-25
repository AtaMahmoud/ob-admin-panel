import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/models/seapod.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/pages/seapod_owner_page.dart';
import 'package:ob_admin_panel/src/ui/widgets/admin_panel_header.dart';
import 'package:ob_admin_panel/src/ui/widgets/mobile_left_navigation_drawer.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';
import 'package:provider/provider.dart';

class MobileSeapodDetails extends StatefulWidget {
  @override
  _MobileSeapodDetailsState createState() => _MobileSeapodDetailsState();
}

class _MobileSeapodDetailsState extends State<MobileSeapodDetails> {
  @override
  Widget build(BuildContext context) {
    var textStyle1 = TextStyle(
      color: Color(ColorConstants.MAIN_COLOR),
    );
    var textStyle2 = TextStyle(
      color: Colors.white,
      fontSize: 15,
    );
    var _selectedSeapod = Provider.of<SeaPodsProvider>(context).selectedSeapod;
    var textStyle = TextStyle(
      color: Colors.white,
      fontSize: 15.0,
    );
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
                      _selectedSeapod.owners[0],
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: buildCardInfo1(textStyle2, _selectedSeapod),
            ),
            SliverToBoxAdapter(
              child: buildCardInfo2(textStyle, _selectedSeapod),
            ),
            ...[
              for (var owner in _selectedSeapod.owners) ...[
                SliverToBoxAdapter(
                  child: buildOwnerInfoCard(_selectedSeapod, owner),
                ),
              ]
            ]
          ],
        ),
      ),
    );
  }

  GestureDetector buildOwnerInfoCard(
    SeaPod selectedSeapod,
    String ownerName,
  ) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(SeapodOwnersPage.routeName),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(
              0xFF9BACC2,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //TODO: Add dynamic profile pic
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(
                ImagePaths.AVATAR,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  ConstantTexts.OWNER.toUpperCase() + '(S)',
                  style: TextStyle(
                    color: Color(
                      ColorConstants.TEXT_COLOR,
                    ),
                    fontSize: 15.0,
                  ),
                ),
                Divider(
                  height: 8,
                ),
                Text(
                  ownerName,
                  style: TextStyle(
                    color: Color(
                      ColorConstants.MAIN_COLOR,
                    ),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  height: 35,
                ),
                Row(
                  children: [
                    Text(
                      ConstantTexts.TYPE.toUpperCase(),
                      style: TextStyle(
                        color: Color(
                          ColorConstants.TEXT_COLOR,
                        ),
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      selectedSeapod.seaPodType.toUpperCase(),
                      style: TextStyle(
                        color: Color(
                          ColorConstants.TEXT_COLOR,
                        ),
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Container buildCardInfo2(
    TextStyle textStyle,
    SeaPod _selectedSeapod,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(
          ColorConstants.LOGIN_REGISTER_TEXT_COLOR,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                ImagePaths.LOCATION_ICON,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(ConstantTexts.LOCATION.toUpperCase() + ':',
                      style: textStyle),
                  Text(
                    //TODO: Add dynamic location
                    'Panama Colon',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ConstantTexts.LATITUDE, style: textStyle),
                    Text(
                      _selectedSeapod.location.latitude.toStringAsFixed(6),
                      style: textStyle,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ConstantTexts.LONGITUDE,
                      style: textStyle,
                    ),
                    Text(
                      _selectedSeapod.location.longitude.toStringAsFixed(6),
                      style: textStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildCardInfo1(
    TextStyle textStyle2,
    SeaPod _selectedSeapod,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(ColorConstants.SEAPOD_CARD_BACKGROUND),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ConstantTexts.MODEL,
                style: textStyle2,
              ),
              Text(
                'SP - 12345',
                style: textStyle2,
              ),
              Divider(
                height: 10,
              ),
              Text(
                ConstantTexts.HOME_CODE,
                style: textStyle2,
              ),
              Text(
                _selectedSeapod.vessleCode,
                style: textStyle2,
              ),
              Divider(
                height: 10,
              ),
              Text(
                ConstantTexts.YEAR,
                style: textStyle2,
              ),
              Text(
                '06/06/2020',
                style: textStyle2,
              ),
            ],
          ),
          Container(
            color: Colors.white,
            height: 120,
            width: 120,
            //TODO: add QrCodeImage
            //child: Image.network(_selectedSeapod.qrCodeImageUrl),
          )
        ],
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
