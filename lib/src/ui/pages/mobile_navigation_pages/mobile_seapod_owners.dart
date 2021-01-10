import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/widgets/admin_panel_header.dart';
import 'package:ob_admin_panel/src/ui/widgets/mobile_left_navigation_drawer.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';
import 'package:provider/provider.dart';

class MobileSeapodOwner extends StatefulWidget {
  @override
  _MobileSeapodOwnerState createState() => _MobileSeapodOwnerState();
}

class _MobileSeapodOwnerState extends State<MobileSeapodOwner> {
  @override
  Widget build(BuildContext context) {
    var selectedOwner =
        Provider.of<SeaPodsProvider>(context, listen: false).selectedOwner;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(
          ColorConstants.TAB_BACKGROUND,
        ),
        drawer: MobileLeftNavigationMenu(
          tappedMenuIndex: 0,
        ),
        drawerScrimColor: Color(ColorConstants.DRAWER_SCRIM_COLOR),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MobileHeader(
                    showLogo: false,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 20,
                      bottom: 15,
                    ),
                    child: TabTitle(
                      selectedOwner.userName,
                      fontSize: 22,
                    ),
                  ),
                  ProfileInfoCard(),
                  ContactsInfoCard(),
                  ConnectedHomesInfoCard(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selectedOwner =
        Provider.of<SeaPodsProvider>(context, listen: false).selectedOwner;
    return InfoCard(
      title: ConstantTexts.PROFILE,
      children: [
        InfoRow(
          titleText: ConstantTexts.MEMBER_SINCE,
          infoText: selectedOwner.checkInDate.toString(),
        ),
        InfoRow(
          titleText: ConstantTexts.NATIONALITY,
          infoText: selectedOwner.country,
        ),
        InfoRow(
          titleText: ConstantTexts.LANGUAGES,
          //TODO: Missing info
          infoText: 'English',
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: InfoText(
                //TODO: Missing info
                text: ConstantTexts.HEALTH_CONDITION,
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: InfoText(
                  text: ConstantTexts.VIEW,
                  textColor: ColorConstants.MAIN_COLOR,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ContactsInfoCard extends StatelessWidget {
  const ContactsInfoCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selectedOwner =
        Provider.of<SeaPodsProvider>(context, listen: false).selectedOwner;
    return InfoCard(
      title: ConstantTexts.CONTACTS,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: InfoText(
                text: ConstantTexts.EMAIL,
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: InfoText(
                  text: selectedOwner.email,
                  textColor: ColorConstants.MAIN_COLOR,
                ),
              ),
            ),
          ],
        ),
        InfoRow(
          titleText: ConstantTexts.PHONE,
          infoText: selectedOwner.mobileNumber,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: InfoText(
                text: ConstantTexts.EMMERGENCY_CONTACT,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoText(
                    text: 'Name',
                  ),
                  InfoText(
                    text: 'Phone',
                  ),
                  InfoText(
                    text: 'mail.com',
                    textColor: ColorConstants.MAIN_COLOR,
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
    var selectedOwner =
        Provider.of<SeaPodsProvider>(context, listen: false).selectedOwner;
    return InfoCard(
      title: ConstantTexts.CONNECTED_HOMES,
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
                            color: Color(0xFFC6D7F4),
                            borderRadius: BorderRadius.circular(4)),
                        padding: EdgeInsets.symmetric(
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
    this.textColor = ColorConstants.TABLE_VIEW_TEXT_COLOR,
  }) : super(key: key);

  final String text;
  final textColor;

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
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(
            ColorConstants.TABLE_VIEW_TEXT_COLOR,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              height: 22,
              child: Text(
                title,
                style: TextStyle(
                  color: Color(
                    ColorConstants.TABLE_VIEW_TEXT_COLOR,
                  ),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...[
                  for (var child in children) ...[child]
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
