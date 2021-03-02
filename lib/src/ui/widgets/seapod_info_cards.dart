import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/constants/constant_texts.dart';
import 'package:ob_admin_panel/src/constants/image_paths.dart';
import 'package:ob_admin_panel/src/models/seapod_owner.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/pages/seapod_owner_details/seapod_owner_page.dart';
import 'package:provider/provider.dart';

class OwnerInfoCard extends StatelessWidget {
  const OwnerInfoCard({
    Key key,
    @required this.owner,
  }) : super(key: key);

  final SeapodOwner owner;

  @override
  Widget build(BuildContext context) {
    final seapodsProvider =
        Provider.of<SeaPodsProvider>(context, listen: false);
    final selectedSeapod = seapodsProvider.selectedSeapod;
    return GestureDetector(
      onTap: () {
        seapodsProvider.updateSelectedOwner(owner);
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                SeapodOwnersPage(),
            transitionDuration: const Duration(),
            settings: const RouteSettings(name: SeapodOwnersPage.routeName),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(
              0xFF9BACC2,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //TODO: Add dynamic profile pic
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(
                ImagePaths.defaultAvatar,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${ConstantTexts.owner.toUpperCase()}(S)',
                  style: const TextStyle(
                    color: Color(
                      ColorConstants.textColor,
                    ),
                    fontSize: 15.0,
                  ),
                ),
                const Divider(
                  height: 8,
                ),
                Text(
                  owner.userName,
                  style: const TextStyle(
                    color: Color(
                      ColorConstants.mainColor,
                    ),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(
                  height: 35,
                ),
                Row(
                  children: [
                    Text(
                      ConstantTexts.type.toUpperCase(),
                      style: const TextStyle(
                        color: Color(
                          ColorConstants.textColor,
                        ),
                        fontSize: 15.0,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      selectedSeapod.seaPodType.toUpperCase(),
                      style: const TextStyle(
                        color: Color(
                          ColorConstants.textColor,
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
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 15.0,
    );
    final _selectedSeapod =
        Provider.of<SeaPodsProvider>(context, listen: false).selectedSeapod;
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(
          ColorConstants.loginRegisterTextColor,
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
                ImagePaths.locationIcon,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${ConstantTexts.location.toUpperCase()}:',
                    style: textStyle,
                  ),
                  const Text(
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
                    const Text(
                      ConstantTexts.latitude,
                      style: textStyle,
                    ),
                    Text(
                      _selectedSeapod.location.latitude.toStringAsFixed(6),
                      style: textStyle,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      ConstantTexts.longitude,
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
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 15,
    );
    final _selectedSeapod =
        Provider.of<SeaPodsProvider>(context, listen: false).selectedSeapod;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: isDesktop ? 0 : 10,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(ColorConstants.seapodCardBackground),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                ConstantTexts.model,
                style: textStyle,
              ),
              const Text(
                'SP - 12345',
                style: textStyle,
              ),
              const Divider(
                height: 5,
              ),
              const Text(
                ConstantTexts.homeCode,
                style: textStyle,
              ),
              Text(
                _selectedSeapod.vessleCode,
                style: textStyle,
              ),
              const Divider(
                height: 10,
              ),
              const Text(
                ConstantTexts.year,
                style: textStyle,
              ),
              const Text(
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
