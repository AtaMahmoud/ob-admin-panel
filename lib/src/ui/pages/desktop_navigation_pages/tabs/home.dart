import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/models/seapod.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
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
    return RotatedBox(
      quarterTurns: Constants.TURNS_TO_ROTATE_LEFT,
      child: FractionallySizedBox(
        alignment: Alignment.topLeft,
        widthFactor: 0.8,
        heightFactor: 0.95,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 30,
            top: 25,
            bottom: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabTitle(ConstantTexts.SEAPODS),
              SizedBox(
                height: 20,
              ),
              buildTableHeader(),
              if (!_isInit) buildTableContent(),
            ],
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

  Widget buildTableContent() {
    var itemCount = seaPodsProvider.allSeaPods.data.length;
    return Expanded(
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
        seaPod.owners.join(', '),
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
      height: 40,
      width: MediaQuery.of(context).size.width * 0.8,
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
      child: Padding(
        padding: const EdgeInsets.only(
          top: 15,
          right: 10,
        ),
        child: Container(
          height: 25,
          child: Text(
            cellName.toUpperCase(),
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
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
            fontSize: 9,
            fontWeight: FontWeight.w500,
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
                fontSize: 9,
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
