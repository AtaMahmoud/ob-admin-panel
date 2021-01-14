import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/helpers/size_calcs.dart';
import 'package:ob_admin_panel/src/models/seapod.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/widgets/map_tab.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';
import 'package:provider/provider.dart';

class SeapodsView extends StatefulWidget {
  final int tabIndex;
  final VoidCallback onMapTap;
  final VoidCallback onListTap;

  SeapodsView({
    @required this.tabIndex,
    @required this.onMapTap,
    @required this.onListTap,
  });

  @override
  _SeapodsViewState createState() => _SeapodsViewState();
}

class _SeapodsViewState extends State<SeapodsView>
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
    var allSeapods = seaPodsProvider.allSeaPods.data;
    var sizeCalcs = SizeCalcs(context: context);
    final tabViewWidth = sizeCalcs.calculateTabViewWidth();

    return Container(
      color: Color(
        widget.tabIndex == 1
            ? ColorConstants.MAP_BACKGROUND
            : ColorConstants.TAB_BACKGROUND,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 30,
              top: 25,
            ),
            height: 75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TabTitle(
                  ConstantTexts.SEAPODS,
                ),
                Container(
                  height: 30,
                  child: Row(
                    children: [
                      buildSwitcher(
                        widget.onMapTap,
                        ConstantTexts.MAP,
                        BoxDecoration(
                          color: Color(
                            widget.tabIndex == 1
                                ? ColorConstants.SWITCHER_COLOR
                                : ColorConstants.LOGIN_REGISTER_TEXT_COLOR,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        color: Colors.white,
                      ),
                      buildSwitcher(
                        widget.onListTap,
                        ConstantTexts.LIST,
                        BoxDecoration(
                          color: Color(
                            widget.tabIndex == 0
                                ? ColorConstants.SWITCHER_COLOR
                                : ColorConstants.LOGIN_REGISTER_TEXT_COLOR,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          if (widget.tabIndex == 0)
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 30,
                bottom: 30,
              ),
              margin: EdgeInsets.only(right: tabViewWidth * 0.15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTableHeader(),
                  if (!_isInit)
                    buildTableContent(
                      allSeapods,
                    )
                ],
              ),
            ),
          if (!_isInit && widget.tabIndex == 1)
            Container(
              margin: EdgeInsets.only(right: tabViewWidth * 0.15),
              height: 600,
              child: MapTab(
                seapods: allSeapods,
              ),
            ),
        ],
      ),
    );
  }

  GestureDetector buildSwitcher(
    Function onTap,
    String text,
    BoxDecoration decoration,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: decoration,
        width: 80,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDivider() {
    return Container(
      height: 1,
      color: const Color(
        ColorConstants.TABLE_VIEW_DIVIDER_COLOR,
      ),
    );
  }

  Widget buildTableContent(List<SeaPod> seapods) {
    var itemCount = seapods.length;
    return Container(
      height: 500,
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 10,
            ),
            child: Column(
              children: [
                Row(
                  children: _seapodDetails(
                    seaPodsProvider.allSeaPods.data[index],
                  ),
                ),
                if (index != itemCount - 1) buildDivider(),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _seapodDetails(SeaPod seaPod) {
    return [
      buildTableCell(
        seaPod.seaPodName,
      ),
      buildTableCell(
        seaPod.ownersNames.join(', '),
      ),
      buildTableCell(
        seaPod.seaPodType,
      ),
      buildLocationField(
        seaPod.location,
      ),
      buildTableCell(
        seaPod.seaPodStatus,
      ),
      buildTableCell(
        seaPod.accessLevel,
      ),
    ];
  }

  Widget buildTableHeader() {
    return Container(
      height: 50,
      padding: EdgeInsets.only(
        left: 20,
        right: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
        color: const Color(
          ColorConstants.SEAPOD_TABLE_HEADER_BACKGROUND,
        ),
      ),
      child: Row(
        children: _tableFieldsList(),
      ),
    );
  }

  List<Widget> _tableFieldsList() {
    return [
      buildTableField(
        ConstantTexts.SEAPOD,
      ),
      buildTableField(
        ConstantTexts.OWNER,
      ),
      buildTableField(
        ConstantTexts.TYPE,
      ),
      buildTableField(
        ConstantTexts.LOCATION,
      ),
      buildTableField(
        ConstantTexts.STATUS,
      ),
      buildTableField(
        ConstantTexts.ACCESS_LEVEL,
      ),
    ];
  }

  Widget buildTableField(
    String cellName,
  ) {
    return Expanded(
      child: Text(
        cellName.toUpperCase(),
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildTableCell(
    String cellName,
  ) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 5,
          right: 10,
          bottom: 5,
        ),
        child: Text(
          cellName,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(
              ColorConstants.TABLE_VIEW_TEXT_COLOR,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLocationField(
    Location seaPodLocation,
  ) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 5,
          right: 20,
          bottom: 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              seaPodLocation.locationName,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(ColorConstants.TABLE_VIEW_TEXT_COLOR),
              ),
            ),
            Text(
              ConstantTexts.LATITUDE +
                  seaPodLocation.latitude.toStringAsFixed(4),
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w500,
                color: Color(ColorConstants.TABLE_VIEW_TEXT_COLOR),
              ),
            ),
            Text(
              ConstantTexts.LONGITUDE +
                  seaPodLocation.longitude.toStringAsFixed(4),
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w500,
                color: Color(ColorConstants.TABLE_VIEW_TEXT_COLOR),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
