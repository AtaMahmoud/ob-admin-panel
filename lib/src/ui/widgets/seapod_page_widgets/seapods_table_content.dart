import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/models/field.dart';
import 'package:ob_admin_panel/src/models/seapod.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/pages/seapod_details/seapod_datails_page.dart';
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

  Widget tableFieldContent(
    String content,
  ) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 5,
          right: 10,
          bottom: 5,
        ),
        child: Text(
          content,
          textAlign: TextAlign.start,
          style: tableContentTextStyle(),
        ),
      ),
    );
  }

  List<Widget> _seapodDetails(SeaPod seaPod) {
    return [
      if (widget.columns[0].isChecked)
        tableFieldContent(
          seaPod.seaPodName,
        ),
      if (widget.columns[1].isChecked)
        tableFieldContent(
          seaPod.ownersNames.join(', '),
        ),
      if (widget.columns[2].isChecked)
        tableFieldContent(
          seaPod.seaPodType,
        ),
      if (widget.columns[3].isChecked)
        buildLocationField(
          seaPod.location,
        ),
      if (widget.columns[4].isChecked)
        tableFieldContent(
          seaPod.seaPodStatus,
        ),
      if (widget.columns[5].isChecked)
        tableFieldContent(
          seaPod.accessLevel,
        ),
    ];
  }
}