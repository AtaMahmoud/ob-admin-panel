import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/image_paths.dart';

class FilterIcon extends StatelessWidget {
  const FilterIcon({this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Image.asset(
          ImagePaths.tableFilterIcon,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}
