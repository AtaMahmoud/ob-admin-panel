import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/helpers/api_response.dart';
import 'package:ob_admin_panel/src/models/seapod.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/pages/seapod_datails.dart';
import 'package:ob_admin_panel/src/ui/widgets/admin_panel_header.dart';
import 'package:ob_admin_panel/src/ui/widgets/map_tab.dart';
import 'package:ob_admin_panel/src/ui/widgets/mobile_left_navigation_drawer.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class MobileHomePage extends StatefulWidget {
  final int tabIndex;
  final VoidCallback onMapTap;
  final VoidCallback onListTap;
  final VoidCallback onMoreButtonTap;

  MobileHomePage({
    @required this.tabIndex,
    @required this.onMapTap,
    @required this.onListTap,
    @required this.onMoreButtonTap,
  });
  @override
  _MobileHomePageState createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage>
    with SingleTickerProviderStateMixin {
  var _isInit = true;
  SeaPodsProvider seaPodsProvider;
  @override
  void didChangeDependencies() async {
    if (_isInit) {
      seaPodsProvider = Provider.of<SeaPodsProvider>(
        context,
        listen: false,
      );
      await seaPodsProvider.getAllSeapods();
      setState(() {});
      _isInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var _textStyle = TextStyle(
      color: Color(0xFF043D8D),
      fontSize: 18,
      fontWeight: FontWeight.w700,
    );
    var allSeapods = seaPodsProvider.allSeaPods;
    return Scaffold(
      drawer: MobileLeftNavigationMenu(
        tappedMenuIndex: 0,
      ),
      drawerScrimColor: Color(ColorConstants.DRAWER_SCRIM_COLOR),
      body: SafeArea(
        child: Column(
          children: [
            if (widget.tabIndex != 2) MobileHeader(),
            if (widget.tabIndex != 2)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TabTitle(
                      widget.tabIndex == 0
                          ? ConstantTexts.SEAPODS
                          : ConstantTexts.MAP,
                    ),
                    Container(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: widget.onListTap,
                            child: Text(
                              ConstantTexts.LIST,
                              style: _textStyle,
                            ),
                          ),
                          Text(
                            '|',
                            style: _textStyle,
                          ),
                          GestureDetector(
                            onTap: widget.onMapTap,
                            child: Text(
                              ConstantTexts.MAP,
                              style: _textStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            if (allSeapods.status == Status.LOADING || allSeapods.data == null)
              Container(
                height: 300,
                child: SpinKitFadingCircle(
                  color: Color(ColorConstants.MAIN_COLOR),
                  size: 50,
                ),
              ),
            if (allSeapods.status == Status.COMPLETED &&
                allSeapods.data != null)
              Expanded(
                child: IndexedStack(
                  index: widget.tabIndex,
                  children: [
                    SeapodsView(allSeapods: allSeapods.data),
                    MapTab(
                      seapods: allSeapods.data,
                      onMorebuttonTapped: widget.onMoreButtonTap,
                    ),
                    SeapodDetailsPage()
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SeapodsView extends StatelessWidget {
  const SeapodsView({
    Key key,
    @required this.allSeapods,
  }) : super(key: key);

  final List<SeaPod> allSeapods;
  Widget buildSeapodCardText(
    String text,
  ) {
    return Text(
      text,
      style: TextStyle(
        color: Color(
          ColorConstants.TABLE_VIEW_TEXT_COLOR,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: allSeapods.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(15.0),
          height: 230,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: index % 2 == 0
                ? Colors.white
                : Color(ColorConstants.SEAPODS_CARD_BACKGROUND),
            border: Border.all(
              color: Color(ColorConstants.TABLE_VIEW_TEXT_COLOR),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: _mediaQuery.width * 0.35,
                    child: buildSeapodCardText(ConstantTexts.NAME),
                  ),
                  Expanded(
                    child: buildSeapodCardText(
                      allSeapods[index].seaPodName,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: _mediaQuery.width * 0.35,
                    child: buildSeapodCardText(ConstantTexts.OWNER),
                  ),
                  Expanded(
                    child: buildSeapodCardText(
                      allSeapods[index].owners.join(', '),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: _mediaQuery.width * 0.35,
                    child: buildSeapodCardText(ConstantTexts.TYPE),
                  ),
                  buildSeapodCardText(allSeapods[index].seaPodType),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: _mediaQuery.width * 0.35,
                    child: buildSeapodCardText(ConstantTexts.LOCATION),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSeapodCardText(
                          allSeapods[index].location.locationName),
                      buildSeapodCardText(ConstantTexts.LATITUDE +
                          allSeapods[index]
                              .location
                              .latitude
                              .toStringAsFixed(4)),
                      buildSeapodCardText(ConstantTexts.LONGITUDE +
                          allSeapods[index]
                              .location
                              .longitude
                              .toStringAsFixed(4)),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: _mediaQuery.width * 0.35,
                    child: buildSeapodCardText(ConstantTexts.STATUS),
                  ),
                  buildSeapodCardText(allSeapods[index].seaPodStatus),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: _mediaQuery.width * 0.35,
                    child: buildSeapodCardText(ConstantTexts.ACCESS_LEVEL),
                  ),
                  buildSeapodCardText(allSeapods[index].accessLevel),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
