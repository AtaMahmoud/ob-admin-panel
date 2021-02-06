import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedOwner =
        Provider.of<SeaPodsProvider>(context, listen: false).selectedOwner;
    return InfoCard(
      title: ConstantTexts.profile,
      children: [
        InfoRow(
          titleText: ConstantTexts.memberSince,
          infoText: formatDate(selectedOwner.checkInDate),
        ),
        InfoRow(
          titleText: ConstantTexts.nationality,
          infoText: selectedOwner.country,
        ),
        const InfoRow(
          titleText: ConstantTexts.languages,
          /// TODO: Missing info
          infoText: 'English',
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: InfoText(
                // TODO: Missing info
                text: ConstantTexts.healthCondition,
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: const InfoText(
                  text: ConstantTexts.view,
                  textColor: ColorConstants.mainColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String formatDate(
    int checkInDate,
  ) {
    final date = DateTime.fromMillisecondsSinceEpoch(checkInDate);
    return DateFormat.yMMMd().format(date);
  }
}

class ContactsInfoCard extends StatelessWidget {
  const ContactsInfoCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedOwner =
        Provider.of<SeaPodsProvider>(context, listen: false).selectedOwner;
    return InfoCard(
      title: ConstantTexts.contacts,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: InfoText(
                text: ConstantTexts.email,
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: InfoText(
                  text: selectedOwner.email,
                  textColor: ColorConstants.mainColor,
                ),
              ),
            ),
          ],
        ),
        InfoRow(
          titleText: ConstantTexts.phone,
          infoText: selectedOwner.mobileNumber,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: InfoText(
                text: ConstantTexts.emmergencyContact,
              ),
            ),
            if (selectedOwner.emergencyContacts == null ||
                selectedOwner.emergencyContacts.isEmpty)
              const Expanded(
                child: InfoText(text: 'Not set yet'),
              ),
            if (selectedOwner.emergencyContacts != null &&
                selectedOwner.emergencyContacts.isNotEmpty)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoText(
                      text:
                          '${selectedOwner.emergencyContacts[0].firstName} ${selectedOwner.emergencyContacts[0].lastName}',
                    ),
                    InfoText(
                      text: selectedOwner.emergencyContacts[0].mobileNumber,
                    ),
                    InfoText(
                      text: selectedOwner.emergencyContacts[0].email,
                      textColor: ColorConstants.mainColor,
                    )
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class ConnectedHomesInfoCard extends StatelessWidget {
  const ConnectedHomesInfoCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedOwner =
        Provider.of<SeaPodsProvider>(context, listen: false).selectedOwner;
    return InfoCard(
      title: ConstantTexts.connectedHomes,
      children: [
        ...[
          for (var seapod in selectedOwner.seapods) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: InfoText(
                    text: seapod.seapodName,
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFFC6D7F4),
                            borderRadius: BorderRadius.circular(4)),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        width: 90,
                        height: 25,
                        child: Center(
                          child: InfoText(
                            text: seapod.userType,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]
        ]
      ],
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({
    Key key,
    @required this.titleText,
    @required this.infoText,
  }) : super(key: key);

  final String titleText;
  final String infoText;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: InfoText(text: titleText),
        ),
        Expanded(
          child: InfoText(
            text: infoText,
          ),
        ),
      ],
    );
  }
}

class InfoText extends StatelessWidget {
  const InfoText({
    Key key,
    @required this.text,
    this.textColor = ColorConstants.tableViewTextColor,
  }) : super(key: key);

  final String text;
  final int textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Color(
          textColor,
        ),
        fontSize: 16,
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key key,
    @required this.title,
    @required this.children,
  }) : super(key: key);

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(
            0xFF9BACC2,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SizedBox(
              height: 22,
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(
                    ColorConstants.tableViewTextColor,
                  ),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: children),
          ),
        ],
      ),
    );
  }
}
