import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';

class SizeCalcs {
  BuildContext context;
  final _mediaQuery;

  SizeCalcs({
    @required this.context,
  }) : _mediaQuery = MediaQuery.of(context).size;

  double calculateTabViewWidth() {
    return _mediaQuery.height -
        Constants.HEADER_HEIGHT -
        Constants.BOTTOM_APP_PADDING_HEIGHT;
  }

  double calculateTabViewHeight() {
    return _mediaQuery.width - Constants.LEFT_NAVIGATION_WIDTH;
  }
}
