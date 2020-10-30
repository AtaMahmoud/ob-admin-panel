import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/ui/widgets/admin_panel_header.dart';
import 'package:ob_admin_panel/src/ui/widgets/mobile_left_navigation_drawer.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';

class MobileSeapodsPage extends StatefulWidget {
  @override
  _MobileSeapodsPageState createState() => _MobileSeapodsPageState();
}

class _MobileSeapodsPageState extends State<MobileSeapodsPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var _textStyle = TextStyle(
      color: Color(0xFF043D8D),
      fontSize: 18,
      fontWeight: FontWeight.w700,
    );
    var _mediaQuery = MediaQuery.of(context).size;
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
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
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
                          children: [
                            Container(
                              width: _mediaQuery.width * 0.35,
                              child: buildSeapodCardText(ConstantTexts.NAME),
                            ),
                            buildSeapodCardText('SECOND WIND')
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: _mediaQuery.width * 0.35,
                              child: buildSeapodCardText(ConstantTexts.OWNER),
                            ),
                            buildSeapodCardText('GRANT REMUNDT'),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: _mediaQuery.width * 0.35,
                              child: buildSeapodCardText(ConstantTexts.TYPE),
                            ),
                            buildSeapodCardText('Private'),
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
                                buildSeapodCardText(
                                    ConstantTexts.LATITUDE + '12.979807'),
                                buildSeapodCardText(
                                    ConstantTexts.LONGITUDE + '12.979807')
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
                            buildSeapodCardText('OK'),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: _mediaQuery.width * 0.35,
                              child: buildSeapodCardText(
                                  ConstantTexts.ACCESS_LEVEL),
                            ),
                            buildSeapodCardText('Property Manager'),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                childCount: 20,
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
