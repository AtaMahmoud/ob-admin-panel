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

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ThemeData _adminPanelTheme() {
    return ThemeData(
      fontFamily: 'Montserrat',
      primaryColor: Color(
        ColorConstants.MAIN_COLOR,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Color(
          ColorConstants.MAIN_COLOR,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AdminAuthProvider _adminProvider = AdminAuthProvider();
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
                if (_adminProvider.authenticatedAdmin != null)
                  return HomePage();
                else
                  return LoginPage();
              }

              return SplashScreen();
            },
          ),
          routes: {
            LoginPage.routeName: (BuildContext context) => LoginPage(),
            RegisterPage.routeName: (BuildContext context) => RegisterPage(),
            HomePage.routeName: (BuildContext context) => HomePage(),
            SeapodDetailsPage.routeName: (BuildContext context) =>
                SeapodDetailsPage(),
            SeapodOwnersPage.routeName: (BuildContext context) =>
                SeapodOwnersPage(),
          },
        ));
  }
}
