import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/constants/constant_texts.dart';
import 'package:ob_admin_panel/src/models/field.dart';
import 'package:ob_admin_panel/src/models/seapod.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/pages/seapod_details/seapod_datails_page.dart';
import 'package:provider/provider.dart';

class MobileSeapodsView extends StatelessWidget {
  const MobileSeapodsView({
    Key key,
    @required this.allSeapods,
    @required this.fields,
  }) : super(key: key);

  final List<SeaPod> allSeapods;
  final List<Field> fields;

  @override
  Widget build(BuildContext context) {
    final seaPodsProvider = Provider.of<SeaPodsProvider>(context);
    return ListView.builder(
      itemCount: allSeapods.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            seaPodsProvider.updateSelectedSeapod(allSeapods[index]);
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
            padding: const EdgeInsets.only(top: 10.0),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: index % 2 == 0
                  ? Colors.white
                  : const Color(ColorConstants.seapodsCardBackground),
              border: Border.all(
                color: const Color(ColorConstants.tableViewTextColor),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Name row
                SeapodInformationRow(
                  visible: true,
                  titleText: fields[0].fieldName,
                  infoText: allSeapods[index].seaPodName,
                ),
                //Owner row
                SeapodInformationRow(
                  visible: fields[1].isChecked,
                  titleText: fields[1].fieldName,
                  infoText: allSeapods[index].ownersNames.join(', '),
                ),
                //Type row
                SeapodInformationRow(
                  visible: fields[2].isChecked,
                  titleText: fields[2].fieldName,
                  infoText: allSeapods[index].seaPodType,
                ),
                //Location row
                SeapodInformationRow(
                  visible: fields[3].isChecked,
                  titleText: fields[3].fieldName,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SeapodCardText(
                        text: allSeapods[index].location.locationName,
                      ),
                      SeapodCardText(
                        text: ConstantTexts.latitude +
                            allSeapods[index]
                                .location
                                .latitude
                                .toStringAsFixed(4),
                      ),
                      SeapodCardText(
                        text: ConstantTexts.longitude +
                            allSeapods[index]
                                .location
                                .longitude
                                .toStringAsFixed(4),
                      ),
                    ],
                  ),
                ),
                //Status row
                SeapodInformationRow(
                  visible: fields[4].isChecked,
                  titleText: fields[4].fieldName,
                  infoText: allSeapods[index].seaPodStatus,
                ),
                //Access Level row
                SeapodInformationRow(
                  visible: fields[5].isChecked,
                  titleText: fields[5].fieldName,
                  infoText: allSeapods[index].accessLevel,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SeapodInformationRow extends StatelessWidget {
  const SeapodInformationRow({
    @required this.titleText,
    @required this.visible,
    this.infoText,
    this.child,
  });

  final String titleText;
  final String infoText;
  final Widget child;
  final bool visible;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Visibility(
      visible: visible,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: mediaQuery.width * 0.35,
              child: SeapodCardText(text: titleText),
            ),
            child ??
                Expanded(
                  child: SeapodCardText(
                    text: infoText,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

class SeapodCardText extends StatelessWidget {
  const SeapodCardText({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(
          ColorConstants.tableViewTextColor,
        ),
      ),
    );
  }
}
