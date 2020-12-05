import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:flutter/services.dart' show rootBundle;

class MapMobileVersion extends StatefulWidget {
  @override
  _MapMobileVersionState createState() => _MapMobileVersionState();
}

class _MapMobileVersionState extends State<MapMobileVersion> {
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  String _mapStyle;

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
        ImageConfiguration(
          size: Size(100, 100),
        ),
        ImagePaths.SEAPOD_LOCATION_MARKER);
  }

  @override
  Widget build(BuildContext context) {
    LatLng pinPosition = LatLng(37.3797536, -122.1017334);

    CameraPosition initialLocation =
        CameraPosition(zoom: 16, bearing: 30, target: pinPosition);
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: initialLocation,
      minMaxZoomPreference: MinMaxZoomPreference.unbounded,
      markers: _markers,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
        controller.setMapStyle(_mapStyle);
        setState(
          () {
            _markers.add(
              Marker(
                markerId: MarkerId('0'),
                position: pinPosition,
                icon: pinLocationIcon,
              ),
            );
          },
        );
      },
    );
  }
}
