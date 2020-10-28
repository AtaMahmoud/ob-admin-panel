import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: Constants.TURNS_TO_ROTATE_LEFT,
      child: FractionallySizedBox(
        alignment: Alignment.topLeft,
        widthFactor: 0.9,
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
              Container(
                height: 60,
                child: Text(
                  ConstantTexts.SEAPODS,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              buildTableHeader(),
              buildTableContent(),
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
    var itemCount = 20;
    return Expanded(
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(
              right: 120,
            ),
            padding: EdgeInsets.only(
              left: 20,
              right: 10,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    buildTableCell(
                      'Second Wind $index',
                    ),
                    buildTableCell(
                      'John Doe',
                    ),
                    buildTableCell(
                      'Private',
                    ),
                    buildLocationField(
                      'Panama',
                      '12.979807',
                      '46.4873986',
                    ),
                    buildTableCell(
                      'Ok',
                    ),
                    buildTableCell(
                      'Property manager',
                    ),
                  ],
                ),
                if (index != itemCount - 1) buildDivider(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildTableHeader() {
    return Container(
      height: 40,
      margin: EdgeInsets.only(
        right: 120,
      ),
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
        children: [
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
        ],
      ),
    );
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
            cellName,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
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
            color: Color(ColorConstants.TABLE_VIEW_TEXT_COLOR),
          ),
        ),
      ),
    );
  }

  Widget buildLocationField(
    String locationName,
    String latitude,
    String longitude,
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
              locationName,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w500,
                color: Color(ColorConstants.TABLE_VIEW_TEXT_COLOR),
              ),
            ),
            Text(
              ConstantTexts.LATITUDE + latitude,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w500,
                color: Color(ColorConstants.TABLE_VIEW_TEXT_COLOR),
              ),
            ),
            Text(
              ConstantTexts.LONGITUDE + longitude,
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
