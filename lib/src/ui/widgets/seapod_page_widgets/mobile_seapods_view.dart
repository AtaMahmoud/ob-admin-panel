import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/models/seapod.dart';

class MobileSeapodsView extends StatelessWidget {
  const MobileSeapodsView({
    Key key,
    @required this.allSeapods,
  }) : super(key: key);

  final List<SeaPod> allSeapods;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allSeapods.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
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
              SeapodInformationRow(
                titleText: ConstantTexts.name,
                infoText: allSeapods[index].seaPodName,
              ),
              SeapodInformationRow(
                titleText: ConstantTexts.owner,
                infoText: allSeapods[index].ownersNames.join(', '),
              ),
              SeapodInformationRow(
                titleText: ConstantTexts.type,
                infoText: allSeapods[index].seaPodType,
              ),
              SeapodInformationRow(
                titleText: ConstantTexts.location,
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
              SeapodInformationRow(
                titleText: ConstantTexts.status,
                infoText: allSeapods[index].seaPodStatus,
              ),
              SeapodInformationRow(
                titleText: ConstantTexts.accessLevel,
                infoText: allSeapods[index].accessLevel,
              ),
            ],
          ),
        );
      },
    );
  }
}

class SeapodInformationRow extends StatelessWidget {
  const SeapodInformationRow(
      {@required this.titleText, this.infoText, this.child});

  final String titleText;
  final String infoText;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Padding(
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
