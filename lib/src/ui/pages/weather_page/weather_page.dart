import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/ui/pages/weather_page/desktop_version.dart';
import 'package:ob_admin_panel/src/ui/pages/weather_page/mobile_version.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WeatherPage extends StatefulWidget {
  static const routeName = '/weather-marine';

  @override
  _SeapodSettingsState createState() => _SeapodSettingsState();
}

class _SeapodSettingsState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return DesktopWeatherPage();
        } else {
          return MobileWeatherPage();
        }
      },
    );
  }
}
