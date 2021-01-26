import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';

class SizeCalcs {
  BuildContext context;
  final Size _mediaQuery;

  SizeCalcs({
    @required this.context,
  }) : _mediaQuery = MediaQuery.of(context).size;

  double calculateTabViewWidth() {
    return _mediaQuery.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right -
        Constants.leftNavigationWidth;
  }
}
