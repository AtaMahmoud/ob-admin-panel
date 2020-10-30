import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/ui/pages/main_page.dart';
import 'package:ob_admin_panel/src/ui/widgets/create_account_button.dart';
import 'package:ob_admin_panel/src/ui/widgets/custom_text_form_field.dart';
import 'package:ob_admin_panel/src/ui/widgets/logo.dart';
import 'package:ob_admin_panel/src/ui/widgets/submit_button.dart';

import 'package:responsive_builder/responsive_builder.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop)
          return DesktopLoginPage();
        else
          return MobileLoginPage();
      },
    );
  }
}

class DesktopLoginPage extends StatefulWidget {
  @override
  _DesktopLoginPageState createState() => _DesktopLoginPageState();
}

class _DesktopLoginPageState extends State<DesktopLoginPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(ColorConstants.LOGIN_CONTAINER_BACKGROUND),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    WebLogo(),
                  ],
                ),
                SizedBox(
                  height: mediaQuery.height * 0.15,
                ),
                Container(
                  width: 342,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          label: ConstantTexts.EMAIL,
                          onSaved: () {},
                          validator: () {},
                        ),
                        SizedBox(
                          height: 29,
                        ),
                        CustomTextFormField(
                          label: ConstantTexts.PASSWORD,
                          isPassword: true,
                          onSaved: () {},
                          validator: () {},
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        Text(
                          ConstantTexts.FORGOT_PASSWORD,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: const Color(
                              ColorConstants.MAIN_COLOR,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 27,
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, MainPage.routeName),
                          child: SubmitButton(),
                        ),
                        SizedBox(
                          height: 27,
                        ),
                        CreateAccountButton()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MobileLoginPage extends StatefulWidget {
  @override
  _MobileLoginPageState createState() => _MobileLoginPageState();
}

class _MobileLoginPageState extends State<MobileLoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(ColorConstants.LOGIN_CONTAINER_BACKGROUND),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 30,
                    bottom: 15,
                  ),
                  child: MobileLogo(),
                ),
                SizedBox(
                  height: mediaQuery.height * 0.1,
                ),
                Container(
                  width: 342,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          label: ConstantTexts.EMAIL,
                          onSaved: () {},
                          validator: () {},
                        ),
                        SizedBox(
                          height: 29,
                        ),
                        CustomTextFormField(
                          label: ConstantTexts.PASSWORD,
                          isPassword: true,
                          onSaved: () {},
                          validator: () {},
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        Text(
                          ConstantTexts.FORGOT_PASSWORD,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: const Color(
                              ColorConstants.MAIN_COLOR,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 27,
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, MainPage.routeName),
                          child: SubmitButton(),
                        ),
                        SizedBox(
                          height: 27,
                        ),
                        CreateAccountButton()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
