import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/providers/admin_auth_provider.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/pages/home_page.dart';
import 'package:ob_admin_panel/src/ui/pages/login.dart';
import 'package:ob_admin_panel/src/ui/pages/register.dart';
import 'package:ob_admin_panel/src/ui/pages/seapod_datails.dart';
import 'package:ob_admin_panel/src/ui/pages/seapod_owner_page.dart';
import 'package:ob_admin_panel/src/ui/pages/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
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
                  return const HomePage();
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
            HomePage.routeName: (BuildContext context) => const HomePage(),
            SeapodDetailsPage.routeName: (BuildContext context) =>
                SeapodDetailsPage(),
            SeapodOwnersPage.routeName: (BuildContext context) =>
                SeapodOwnersPage(),
          },
        ));
  }
}
