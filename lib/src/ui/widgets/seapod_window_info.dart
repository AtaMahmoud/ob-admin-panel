import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/models/seapod.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:speech_bubble/speech_bubble.dart';

class SeaPodInfoWindow extends StatefulWidget {
  @override
  _SeaPodInfoWindowState createState() => _SeaPodInfoWindowState();
}

class _SeaPodInfoWindowState extends State<SeaPodInfoWindow> {
  @override
  Widget build(BuildContext context) {
    final selectedSeapod = Provider.of<SeaPodsProvider>(context).selectedSeapod;
    const divider = Divider(
      color: Colors.white,
      thickness: 1,
      height: 35,
    );
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Container(
          margin: sizingInformation.deviceScreenType == DeviceScreenType.desktop
              ? const EdgeInsets.only(top: 30, left: 20)
              : EdgeInsets.zero,
          child: SpeechBubble(
            nipHeight: 20,
            height:
                sizingInformation.deviceScreenType == DeviceScreenType.desktop
                    ? 175
                    : 420,
            width:
                sizingInformation.deviceScreenType == DeviceScreenType.desktop
                    ? 430
                    : 250,
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            color: const Color(ColorConstants.loginRegisterTextColor)
                .withOpacity(0.85),
            nipLocation: NipLocation.RIGHT,
            borderRadius: 8.0,
            child: sizingInformation.deviceScreenType ==
                    DeviceScreenType.desktop
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleWidget(
                            '${ConstantTexts.name}: ',
                          ),
                          infoWidget(
                            selectedSeapod.seaPodName,
                          ),
                          titleWidget(
                            '${ConstantTexts.owner}: ',
                          ),
                          infoWidget(
                            selectedSeapod.ownersNames.join(', '),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const MoreButton(),
                        ],
                      ),
                      divider2(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleWidget(
                            '${ConstantTexts.location}: ',
                          ),
                          infoWidget(
                            selectedSeapod.location.locationName,
                          ),
                          titleWidget(
                            ConstantTexts.latitude,
                          ),
                          infoWidget(
                            selectedSeapod.location.latitude.toStringAsFixed(4),
                          ),
                          titleWidget(
                            ConstantTexts.logitude,
                          ),
                          infoWidget(
                            selectedSeapod.location.longitude
                                .toStringAsFixed(4),
                          ),
                        ],
                      ),
                      divider2(),
                      infoWidget(
                          '${ConstantTexts.status}: ${selectedSeapod.seaPodStatus}')
                    ],
                  )
                : mobileVersion(selectedSeapod, divider),
          ),
        );
      },
    );
  }

  Container divider2() {
    return Container(
      height: 140,
      width: 1,
      color: Colors.white,
    );
  }

  Column mobileVersion(SeaPod selectedSeapod, Divider divider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget(
          '${ConstantTexts.name}: ',
        ),
        infoWidget(
          selectedSeapod.seaPodName,
        ),
        titleWidget(
          '${ConstantTexts.owner}: ',
        ),
        infoWidget(
          selectedSeapod.ownersNames.join(', '),
        ),
        const MoreButton(),
        divider,
        titleWidget(
          '${ConstantTexts.location}: ',
        ),
        infoWidget(
          selectedSeapod.location.locationName,
        ),
        titleWidget(
          ConstantTexts.latitude,
        ),
        infoWidget(
          selectedSeapod.location.latitude.toStringAsFixed(4),
        ),
        titleWidget(
          ConstantTexts.logitude,
        ),
        infoWidget(
          selectedSeapod.location.longitude.toStringAsFixed(4),
        ),
        divider,
        infoWidget('${ConstantTexts.status}: ${selectedSeapod.seaPodStatus}')
      ],
    );
  }

  Widget titleWidget(
    String text,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 3,
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget infoWidget(
    String text,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}

class MoreButton extends StatelessWidget {
  const MoreButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const HomePage(
              seapodDetailsPage: true,
            ),
            transitionDuration: const Duration(),
            settings: const RouteSettings(name: HomePage.routeName),
          ),
        );
      },
      child: Container(
        height: 30,
        width: 100,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
        ),
        child: const Center(
          child: Text(
            'More',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
