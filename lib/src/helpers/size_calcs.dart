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
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).padding.top -
        Constants.HEADER_HEIGHT -
        Constants.BOTTOM_APP_PADDING_HEIGHT;
  }

  double calculateTabViewHeight() {
    return _mediaQuery.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right -
        Constants.LEFT_NAVIGATION_WIDTH;
  }
}
