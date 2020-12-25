import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/ui/widgets/admin_panel_header.dart';
import 'package:ob_admin_panel/src/ui/widgets/mobile_left_navigation_drawer.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';

class MobileSeapodOwners extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                      'John Doe',
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
    return InfoCard(
      title: ConstantTexts.PROFILE,
      children: [
        InfoRow(
          titleText: ConstantTexts.MEMBER_SINCE,
          infoText: '12/2/2020',
        ),
        InfoRow(
          titleText: ConstantTexts.GENDER,
          infoText: 'Male',
        ),
        InfoRow(
          titleText: ConstantTexts.NATIONALITY,
          infoText: 'Egypt',
        ),
        InfoRow(
          titleText: ConstantTexts.LANGUAGES,
          infoText: 'English',
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: InfoText(
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
                  text: 'shimaa@oceanbuilders.com',
                  textColor: ColorConstants.MAIN_COLOR,
                ),
              ),
            ),
          ],
        ),
        InfoRow(
          titleText: ConstantTexts.PHONE,
          infoText: '+244581',
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
                  text: 'name@mail.com',
                  textColor: ColorConstants.MAIN_COLOR,
                )
              ],
            )),
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
    return InfoCard(
      title: ConstantTexts.CONNECTED_HOMES,
      children: [],
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
          ...[
            for (var child in children) ...[child]
          ]
        ],
      ),
    );
  }
}
