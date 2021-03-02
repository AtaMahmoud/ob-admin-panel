import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/constants/constant_texts.dart';
import 'package:ob_admin_panel/src/constants/image_paths.dart';
import 'package:ob_admin_panel/src/models/seapod_location.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
    return ResponsiveBuilder(
      builder: (context, sizingInfo) {
        return Padding(
          padding: const EdgeInsets.only(
            right: 20,
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  sizingInfo.deviceScreenType == DeviceScreenType.desktop
                      ? 6
                      : sizingInfo.deviceScreenType == DeviceScreenType.tablet
                          ? 4
                          : 2,
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
          ),
        );
      },
    );
  }
}
