import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:ob_admin_panel/src/models/seapod.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/widgets/seapod_window_info.dart';
import 'package:provider/provider.dart';

class MapMobileVersion extends StatefulWidget {
  final List<SeaPod> seapods;
  final VoidCallback onMorebuttonTapped;

  MapMobileVersion({@required this.seapods, this.onMorebuttonTapped});

  @override
  _MapMobileVersionState createState() => _MapMobileVersionState();
}

class _MapMobileVersionState extends State<MapMobileVersion> {
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor pinLocationIcon;
  final Map<String, Marker> _markers = {};
  String _mapStyle;
  var _showInfoWindow = false;
  var _isInit = true;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await setCustomMapPin();
      await setCustomMapStyle();
      setState(() {
        _isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  Future<void> setCustomMapStyle() async {
    _mapStyle = await rootBundle.loadString(Constants.MAP_STYLE_FILE);
  }

  Future<void> setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(20, 20)),
      ImagePaths.SEAPOD_LOCATION_MARKER,
    );
  }

  @override
  Widget build(BuildContext context) {
    LatLng pinPosition = LatLng(
      widget.seapods[0].location.latitude,
      widget.seapods[0].location.longitude,
    );

    CameraPosition initialLocation = CameraPosition(
        zoom: 10,
        bearing: 30,
        target: pinPosition);
    var seapodsProvider = Provider.of<SeaPodsProvider>(context, listen: false);
    return Stack(
      children: [
        if (!_isInit)
          GoogleMap(
            rotateGesturesEnabled: false,
            minMaxZoomPreference: MinMaxZoomPreference(1.2, 20.0),
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
                        position: LatLng(seapod.location.latitude,
                            seapod.location.longitude),
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
              child: SeapodWindowInfo(
                onMoreInfoTapped: widget.onMorebuttonTapped,
              ),
            ),
          )
      ],
    );
  }
}
