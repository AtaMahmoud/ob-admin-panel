import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/helpers/api_response.dart';
import 'package:ob_admin_panel/src/providers/admin_auth_provider.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/widgets/admin_panel_header.dart';
import 'package:ob_admin_panel/src/ui/widgets/mobile_left_navigation_drawer.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class MobileSeapodsPage extends StatefulWidget {
  @override
  _MobileSeapodsPageState createState() => _MobileSeapodsPageState();
}

class _MobileSeapodsPageState extends State<MobileSeapodsPage>
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
    var _mediaQuery = MediaQuery.of(context).size;
    var allSeapods = seaPodsProvider.allSeaPods;
    return Scaffold(
      drawer: MobileLeftNavigationMenu(
        tappedMenuIndex: 0,
      ),
      drawerScrimColor: Color(ColorConstants.DRAWER_SCRIM_COLOR),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: MobileHeader(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TabTitle(
                      ConstantTexts.SEAPODS,
                    ),
                    Container(
                      width: 140,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ConstantTexts.SEAPODS,
                            style: _textStyle,
                          ),
                          Text(
                            '|',
                            style: _textStyle,
                          ),
                          Text(
                            ConstantTexts.MAP,
                            style: _textStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (allSeapods.status == Status.LOADING || allSeapods.data == null)
              SliverToBoxAdapter(
                child: Container(
                  height: 300,
                  child: SpinKitFadingCircle(
                    color: Color(ColorConstants.MAIN_COLOR),
                    size: 50,
                  ),
                ),
              ),
            if (allSeapods.status == Status.COMPLETED &&
                allSeapods.data != null)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(15.0),
                      height: 230,
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                              buildSeapodCardText(
                                  allSeapods.data[index].seaPodName)
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
                                  allSeapods.data[index].owners.join(', '),
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
                              buildSeapodCardText(
                                  allSeapods.data[index].seaPodType),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: _mediaQuery.width * 0.35,
                                child:
                                    buildSeapodCardText(ConstantTexts.LOCATION),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildSeapodCardText('Panama'),
                                  buildSeapodCardText(ConstantTexts.LATITUDE +
                                      allSeapods.data[index].location.latitude
                                          .toStringAsFixed(4)),
                                  buildSeapodCardText(ConstantTexts.LONGITUDE +
                                      allSeapods.data[index].location.longitude
                                          .toStringAsFixed(4)),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: _mediaQuery.width * 0.35,
                                child:
                                    buildSeapodCardText(ConstantTexts.STATUS),
                              ),
                              buildSeapodCardText(
                                  allSeapods.data[index].seaPodStatus),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: _mediaQuery.width * 0.35,
                                child: buildSeapodCardText(
                                    ConstantTexts.ACCESS_LEVEL),
                              ),
                              buildSeapodCardText(
                                  allSeapods.data[index].accessLevel),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: allSeapods.data.length,
                ),
              ),
          ],
        ),
      ),
    );
  }

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
}
