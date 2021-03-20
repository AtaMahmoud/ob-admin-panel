import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/providers/admin_auth_provider.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/pages/access_management/access_management_page.dart';
import 'package:ob_admin_panel/src/ui/pages/devices_page/devices_page.dart';
import 'package:ob_admin_panel/src/ui/pages/locations_page/locations_page.dart';
import 'package:ob_admin_panel/src/ui/pages/login_page.dart';
import 'package:ob_admin_panel/src/ui/pages/messages_page/messages_page.dart';
import 'package:ob_admin_panel/src/ui/pages/register_page.dart';
import 'package:ob_admin_panel/src/ui/pages/seapod_details/seapod_datails_page.dart';
import 'package:ob_admin_panel/src/ui/pages/seapod_owner_details/seapod_owner_page.dart';
import 'package:ob_admin_panel/src/ui/pages/seapod_settings_page/seapod_settings.dart';
import 'package:ob_admin_panel/src/ui/pages/seapods_page/seapods_page.dart';
import 'package:ob_admin_panel/src/ui/pages/splash_screen.dart';
import 'package:ob_admin_panel/src/ui/pages/users_page/users_page.dart';
import 'package:ob_admin_panel/src/ui/pages/weather_page/weather_page.dart';
import 'package:provider/provider.dart';
//import 'package:url_strategy/url_strategy.dart';

import 'src/constants/color_constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ThemeData _adminPanelTheme() {
    return ThemeData(
      fontFamily: 'Montserrat',
      primaryColor: const Color(
        ColorConstants.mainColor,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(
          ColorConstants.mainColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _adminProvider = AdminAuthProvider();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => _adminProvider,
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => SeaPodsProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _adminPanelTheme(),
        title: 'OB Admin Panel',
        home: FutureBuilder(
          future: _adminProvider.autoLogin(),
          builder: (ctx, authResultSnapShot) {
            if (authResultSnapShot.connectionState == ConnectionState.done) {
              if (_adminProvider.authenticatedAdmin != null) {
                return SeapodsPage();
              } else {
                return LoginPage();
              }
            }
            return SplashScreen();
          },
        ),
        routes: {
          LoginPage.routeName: (BuildContext context) => LoginPage(),
          RegisterPage.routeName: (BuildContext context) => RegisterPage(),
          SeapodsPage.routeName: (BuildContext context) => SeapodsPage(),
          SeapodDetailsPage.routeName: (BuildContext context) =>
              SeapodDetailsPage(),
          SeapodOwnersPage.routeName: (BuildContext context) =>
              SeapodOwnersPage(),
          AccessManagementPage.routeName: (BuildContext context) =>
              AccessManagementPage(),
          DevicesPage.routeName: (BuildContext context) => DevicesPage(),
          LocationsPage.routeName: (BuildContext context) => LocationsPage(),
          MessagesPage.routeName: (BuildContext context) => MessagesPage(),
          SeapodSettingsPage.routeName: (BuildContext context) =>
              SeapodSettingsPage(),
          UsersPage.routeName: (BuildContext context) => UsersPage(),
          WeatherPage.routeName: (BuildContext conetext) => WeatherPage(),
        },
      ),
    );
  }
}
