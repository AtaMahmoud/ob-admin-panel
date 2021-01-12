import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/models/seapod_owner.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/pages/main_page.dart';
import 'package:provider/provider.dart';

class OwnerInfoCard extends StatelessWidget {
  const OwnerInfoCard({
    Key key,
    @required this.owner,
  }) : super(key: key);

  final SeapodOwner owner;

  @override
  Widget build(BuildContext context) {
    var seapodsProvider = Provider.of<SeaPodsProvider>(context, listen: false);
    var selectedSeapod = seapodsProvider.selectedSeapod;
    return GestureDetector(
      onTap: () {
        seapodsProvider.updateSelectedOwner(owner);
       Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => HomePage(
              seapodOwnerPage: true,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(
              0xFF9BACC2,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //TODO: Add dynamic profile pic
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(
                ImagePaths.AVATAR,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  ConstantTexts.OWNER.toUpperCase() + '(S)',
                  style: TextStyle(
                    color: Color(
                      ColorConstants.TEXT_COLOR,
                    ),
                    fontSize: 15.0,
                  ),
                ),
                Divider(
                  height: 8,
                ),
                Text(
                  owner.userName,
                  style: TextStyle(
                    color: Color(
                      ColorConstants.MAIN_COLOR,
                    ),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  height: 35,
                ),
                Row(
                  children: [
                    Text(
                      ConstantTexts.TYPE.toUpperCase(),
                      style: TextStyle(
                        color: Color(
                          ColorConstants.TEXT_COLOR,
                        ),
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      selectedSeapod.seaPodType.toUpperCase(),
                      style: TextStyle(
                        color: Color(
                          ColorConstants.TEXT_COLOR,
                        ),
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LocationInfoCard extends StatelessWidget {
  const LocationInfoCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      color: Colors.white,
      fontSize: 15.0,
    );
    var _selectedSeapod =
        Provider.of<SeaPodsProvider>(context, listen: false).selectedSeapod;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(
          ColorConstants.LOGIN_REGISTER_TEXT_COLOR,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                ImagePaths.LOCATION_ICON,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(ConstantTexts.LOCATION.toUpperCase() + ':',
                      style: textStyle),
                  Text(
                    //TODO: Add dynamic location
                    'Panama Colon',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ConstantTexts.LATITUDE, style: textStyle),
                    Text(
                      _selectedSeapod.location.latitude.toStringAsFixed(6),
                      style: textStyle,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ConstantTexts.LONGITUDE,
                      style: textStyle,
                    ),
                    Text(
                      _selectedSeapod.location.longitude.toStringAsFixed(6),
                      style: textStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GeneralInfoCard extends StatelessWidget {
  final bool isDesktop;
  const GeneralInfoCard({
    Key key,
    this.isDesktop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      color: Colors.white,
      fontSize: 15,
    );
    var _selectedSeapod =
        Provider.of<SeaPodsProvider>(context, listen: false).selectedSeapod;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: isDesktop ? 0 : 10,
      ),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(ColorConstants.SEAPOD_CARD_BACKGROUND),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ConstantTexts.MODEL,
                style: textStyle,
              ),
              Text(
                'SP - 12345',
                style: textStyle,
              ),
              Divider(
                height: 5,
              ),
              Text(
                ConstantTexts.HOME_CODE,
                style: textStyle,
              ),
              Text(
                _selectedSeapod.vessleCode,
                style: textStyle,
              ),
              Divider(
                height: 10,
              ),
              Text(
                ConstantTexts.YEAR,
                style: textStyle,
              ),
              Text(
                '06/06/2020',
                style: textStyle,
              ),
            ],
          ),
          Container(
            color: Colors.white,
            height: 120,
            width: 120,
            //TODO: add QrCodeImage
            //child: Image.network(_selectedSeapod.qrCodeImageUrl),
          )
        ],
      ),
    );
  }
}
