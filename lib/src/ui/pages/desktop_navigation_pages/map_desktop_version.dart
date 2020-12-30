import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/models/seapod.dart';
import 'package:ob_admin_panel/src/ui/pages/mobile_navigation_pages/map_mobile_version.dart';

class MapDesktopVersion extends StatefulWidget {
  final List<SeaPod> seapods;
  final VoidCallback onMoreButtonTapped;

  MapDesktopVersion({
    @required this.seapods,
    @required this.onMoreButtonTapped,
  });
  @override
  _MapDesktopVersionState createState() => _MapDesktopVersionState();
}

class _MapDesktopVersionState extends State<MapDesktopVersion> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 80,
        left: 20
      ),
      child: MapMobileVersion(
        seapods: widget.seapods,
        onMorebuttonTapped: widget.onMoreButtonTapped,
      ),
    );
  }
}
