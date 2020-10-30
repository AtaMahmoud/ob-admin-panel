import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/ui/pages/main_page.dart';
import 'package:ob_admin_panel/src/ui/pages/login.dart';
import 'package:ob_admin_panel/src/ui/pages/register.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _adminPanelTheme(),
      title: 'OB Admin Panel',
      routes: {
        '/': (BuildContext context) => LoginPage(),
        RegisterPage.routeName: (BuildContext context) => RegisterPage(),
        MainPage.routeName: (BuildContext context) => MainPage(),
      },
    );
  }
}
