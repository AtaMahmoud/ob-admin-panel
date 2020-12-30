import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/pages/seapod_datails.dart';
import 'package:provider/provider.dart';
import 'package:speech_bubble/speech_bubble.dart';

class SeapodWindowInfo extends StatefulWidget {
  final VoidCallback onMoreInfoTapped;

  SeapodWindowInfo({this.onMoreInfoTapped});

  @override
  _SeapodWindowInfoState createState() => _SeapodWindowInfoState();
}

class _SeapodWindowInfoState extends State<SeapodWindowInfo> {
  @override
  Widget build(BuildContext context) {
    var divider = Divider(
      color: Colors.white,
      thickness: 1,
      height: 35,
    );
    var selectedSeapod = Provider.of<SeaPodsProvider>(context).selectedSeapod;
    return SpeechBubble(
      nipHeight: 20,
      height: 420,
      width: 250,
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 15,
      ),
      color: Color(ColorConstants.LOGIN_REGISTER_TEXT_COLOR).withOpacity(0.85),
      nipLocation: NipLocation.RIGHT,
      borderRadius: 8.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleWidget(
            ConstantTexts.NAME + ': ',
          ),
          infoWidget(
            selectedSeapod.seaPodName,
          ),
          titleWidget(
            ConstantTexts.OWNER + ': ',
          ),
          infoWidget(
            selectedSeapod.owners.join(', '),
          ),
          SeapodDetailsWidget(
            onTap: widget.onMoreInfoTapped,
          ),
          divider,
          titleWidget(
            ConstantTexts.LOCATION + ': ',
          ),
          infoWidget(
            selectedSeapod.location.locationName,
          ),
          titleWidget(
            ConstantTexts.LATITUDE,
          ),
          infoWidget(
            selectedSeapod.location.latitude.toStringAsFixed(4),
          ),
          titleWidget(
            ConstantTexts.LONGITUDE,
          ),
          infoWidget(
            selectedSeapod.location.longitude.toStringAsFixed(4),
          ),
          divider,
          infoWidget('${ConstantTexts.STATUS}: ${selectedSeapod.seaPodStatus}')
        ],
      ),
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
        style: TextStyle(
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
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}

class SeapodDetailsWidget extends StatelessWidget {
  const SeapodDetailsWidget({
    Key key,
    this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            Navigator.of(context).pushNamed(
              SeapodDetailsPage.routeName,
            );
          },
      child: Container(
        height: 30,
        width: 100,
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
        ),
        child: Center(
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
