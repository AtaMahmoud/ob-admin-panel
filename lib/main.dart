import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/providers/admin_auth_provider.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/pages/main_page.dart';
import 'package:ob_admin_panel/src/ui/pages/login.dart';
import 'package:ob_admin_panel/src/ui/pages/register.dart';
import 'package:ob_admin_panel/src/ui/pages/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
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
        routes: {
          '/': (BuildContext context) =>
              _adminProvider.authenticatedAdmin != null
                  ? MainPage()
                  : FutureBuilder(
                      future: Provider.of<AdminAuthProvider>(
                        context,
                      ).autoLogin(),
                      builder: (ctx, authResultSnapShot) =>
                          authResultSnapShot.connectionState ==
                                      ConnectionState.active ||
                                  authResultSnapShot.connectionState ==
                                      ConnectionState.waiting
                              ? SplashScreen()
                              : LoginPage(),
                    ),
          LoginPage.routeName: (BuildContext context) => LoginPage(),
          RegisterPage.routeName: (BuildContext context) => RegisterPage(),
          MainPage.routeName: (BuildContext context) => MainPage(),
        },
      ),
    );
  }
}
