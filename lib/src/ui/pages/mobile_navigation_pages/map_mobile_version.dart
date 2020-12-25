import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:ob_admin_panel/src/models/seapod.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/pages/seapod_datails.dart';
import 'package:provider/provider.dart';
import 'package:speech_bubble/speech_bubble.dart';
import 'package:universal_platform/universal_platform.dart';

class MapMobile extends StatelessWidget {
  final List<SeaPod> seapods;

  MapMobile({@required this.seapods});
  @override
  Widget build(BuildContext context) {
    return UniversalPlatform.isAndroid || UniversalPlatform.isIOS
        ? MapMobileVersion(seapods: seapods)
        : Container();
  }
}

class MapMobileVersion extends StatefulWidget {
  final List<SeaPod> seapods;

  MapMobileVersion({@required this.seapods});

  @override
  _MapMobileVersionState createState() => _MapMobileVersionState();
}

class _MapMobileVersionState extends State<MapMobileVersion> {
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor pinLocationIcon;
  final Map<String, Marker> _markers = {};
  String _mapStyle;
  var _showInfoWindow = false;

  @override
  void initState() {
    super.initState();
    setCustomMapPin();
    setCustomMapStyle();
  }

  void setCustomMapStyle() async {
    _mapStyle = await rootBundle.loadString(Constants.MAP_STYLE_FILE);
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      ImagePaths.SEAPOD_LOCATION_MARKER,
    );
  }

  @override
  Widget build(BuildContext context) {
    LatLng pinPosition = LatLng(
      widget.seapods[0].location.latitude,
      widget.seapods[0].location.longitude,
    );

    CameraPosition initialLocation =
        CameraPosition(zoom: 10, bearing: 30, target: pinPosition);
    var seapodsProvider = Provider.of<SeaPodsProvider>(context, listen: false);
    return Stack(
      children: [
        GoogleMap(
          onTap: (_) {
            setState(() {
              _showInfoWindow = false;
            });
          },
          mapType: MapType.normal,
          initialCameraPosition: initialLocation,
          mapToolbarEnabled: false,
          compassEnabled: false,
          markers: _markers.values.toSet(),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            controller.setMapStyle(_mapStyle);
            setState(
              () {
                _markers.clear();
                for (var seapod in widget.seapods) {
                  final marker = Marker(
                      icon: pinLocationIcon,
                      markerId: MarkerId(seapod.seaPodName),
                      position: LatLng(
                          seapod.location.latitude, seapod.location.longitude),
                      onTap: () {
                        setState(() {
                          seapodsProvider.updateSelectedSeapod(seapod);
                          _showInfoWindow = true;
                        });
                      });
                  _markers[seapod.seaPodName] = marker;
                }
              },
            );
          },
        ),
        if (_showInfoWindow)
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.only(right: 30),
              child: SeapodWindowInfo(),
            ),
          )
      ],
    );
  }
}

class SeapodWindowInfo extends StatefulWidget {
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
          SeapodDetailsWidget(),
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
