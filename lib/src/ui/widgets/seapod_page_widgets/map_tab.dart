import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:ob_admin_panel/src/constants/image_paths.dart';
import 'package:ob_admin_panel/src/models/seapod.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/widgets/seapod_window_info.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MapTab extends StatefulWidget {
  final List<SeaPod> seapods;

  const MapTab({
    @required this.seapods,
  });

  @override
  _MapTabState createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  final Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor pinLocationIcon;
  final Map<String, Marker> _markers = {};
  String _mapStyle;
  var _showInfoWindow = false;
  var _isInit = true;

  @override
  Future<void> didChangeDependencies() async {
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
    _mapStyle = await rootBundle.loadString(Constants.mapStyleFile);
  }

  Future<void> setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(30, 30)),
      ImagePaths.seapodLocationMarker,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pinPosition = LatLng(
      widget.seapods[0].location.latitude,
      widget.seapods[0].location.longitude,
    );

    final initialLocation =
        CameraPosition(zoom: 10, bearing: 30, target: pinPosition);
    final seapodsProvider = Provider.of<SeaPodsProvider>(context, listen: false);
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Container(
          padding:
              sizingInformation.deviceScreenType == DeviceScreenType.desktop
                  ? const EdgeInsets.only(left: 20)
                  : EdgeInsets.zero,
          child: Stack(
            children: [
              if (!_isInit)
                GoogleMap(
                  rotateGesturesEnabled: false,
                  minMaxZoomPreference: const MinMaxZoomPreference(1.2, 20.0),
                  onTap: (_) {
                    setState(() {
                      _showInfoWindow = false;
                    });
                  },
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
                        for (final seapod in widget.seapods) {
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
                  alignment: sizingInformation.deviceScreenType ==
                          DeviceScreenType.desktop
                      ? Alignment.topLeft
                      : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(right: 30),
                    child: SeaPodInfoWindow(),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
