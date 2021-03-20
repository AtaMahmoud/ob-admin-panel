import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/constants/constant_texts.dart';
import 'package:ob_admin_panel/src/models/field.dart';
import 'package:ob_admin_panel/src/models/seapod.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/pages/seapod_details/seapod_datails_page.dart';
import 'package:ob_admin_panel/src/ui/widgets/table_field_content.dart';
import 'package:provider/provider.dart';

class SeapodsTableContent extends StatefulWidget {
  const SeapodsTableContent({
    Key key,
    @required this.columns,
  }) : super(key: key);

  final List<Field> columns;

  @override
  _SeapodsTableContentState createState() => _SeapodsTableContentState();
}

class _SeapodsTableContentState extends State<SeapodsTableContent> {
  SeaPodsProvider seaPodsProvider;

  @override
  Widget build(BuildContext context) {
    seaPodsProvider = Provider.of<SeaPodsProvider>(context, listen: false);
    final seapods = seaPodsProvider.allSeaPods.data;
    final customDivider = Container(
      height: 1,
      color: const Color(
        ColorConstants.tableViewDividerColor,
      ),
    );
    final itemCount = seapods.length;
    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              seaPodsProvider.updateSelectedSeapod(seapods[index]);
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      SeapodDetailsPage(),
                  transitionDuration: const Duration(),
                  settings:
                      const RouteSettings(name: SeapodDetailsPage.routeName),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.only(
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
                  if (index != itemCount - 1) customDivider,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  TextStyle tableContentTextStyle() {
    return const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: Color(ColorConstants.tableViewTextColor),
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
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(ColorConstants.tableViewTextColor),
              ),
            ),
            Text(
              ConstantTexts.latitude + seaPodLocation.latitude.toString(),
              textAlign: TextAlign.start,
              style: tableContentTextStyle(),
            ),
            Text(
              ConstantTexts.longitude + seaPodLocation.longitude.toString(),
              textAlign: TextAlign.start,
              style: tableContentTextStyle(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _seapodDetails(SeaPod seaPod) {
    const color = Color(ColorConstants.tableViewTextColor);
    return [
      //Seapod Name row
      TableFieldContent(
        visible: widget.columns[0].isChecked,
        text: seaPod.seaPodName,
        color: color,
      ),
      //Owner Name row
      TableFieldContent(
        visible: widget.columns[1].isChecked,
        text: seaPod.ownersNames.join(', '),
        color: color,
      ),
      //Seapod Type row
      TableFieldContent(
        visible: widget.columns[2].isChecked,
        text: seaPod.seaPodType,
        color: color,
      ),
      //Location row
      Visibility(
        visible: widget.columns[3].isChecked,
        child: buildLocationField(
          seaPod.location,
        ),
      ),
      //Seapod Status row 
      TableFieldContent(
        visible: widget.columns[4].isChecked,
        text: seaPod.seaPodStatus,
        color: color,
      ),
      //Access Level row
      TableFieldContent(
        visible: widget.columns[5].isChecked,
        text: seaPod.accessLevel,
        color: color,
      ),
    ];
  }
}
