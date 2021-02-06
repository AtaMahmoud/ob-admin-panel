import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/models/seapod_location.dart';

class SeapodLocationsCards extends StatefulWidget {
  @override
  _SeapodLocationsCardsState createState() => _SeapodLocationsCardsState();
}

class _SeapodLocationsCardsState extends State<SeapodLocationsCards> {
  List<SeapodLocation> seapodLocations;

  @override
  void initState() {
    intializeSeapodLocations();
    super.initState();
  }

  List<SeapodLocation> intializeSeapodLocations() {
    return seapodLocations = [
      SeapodLocation(
        locationName: ConstantTexts.masterBedroom,
        iconPath: ImagePaths.masterBedroomIcon,
      ),
      SeapodLocation(
        locationName: ConstantTexts.bathroom,
        iconPath: ImagePaths.bathroomIcon,
      ),
      SeapodLocation(
        locationName: ConstantTexts.kitchen,
        iconPath: ImagePaths.kitchenIcon,
      ),
      SeapodLocation(
        locationName: ConstantTexts.livingRoom,
        iconPath: ImagePaths.livingRoomIcon,
      ),
      SeapodLocation(
        locationName: ConstantTexts.entrance,
        iconPath: ImagePaths.entranceIcon,
      ),
      SeapodLocation(
        locationName: ConstantTexts.storage,
        iconPath: ImagePaths.storageIcon,
      ),
      SeapodLocation(
        locationName: ConstantTexts.general,
        iconPath: ImagePaths.generalIcon,
      ),
      SeapodLocation(
        locationName: ConstantTexts.patio,
        iconPath: ImagePaths.patioIcon,
      ),
      SeapodLocation(
        locationName: ConstantTexts.roof,
        iconPath: ImagePaths.roofIcon,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: seapodLocations.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Color(
              index == 1
                  ? ColorConstants.loginRegisterTextColor
                  : ColorConstants.tappedMenuBackground,
            ),
            borderRadius: BorderRadius.circular(6.0),
          ),
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                seapodLocations[index].iconPath,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 100,
                child: Text(
                  seapodLocations[index].locationName,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
