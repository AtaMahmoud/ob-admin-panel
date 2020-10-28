import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/ui/pages/home_page.dart';
import 'package:ob_admin_panel/src/ui/widgets/custom_text_form_field.dart';
import 'package:ob_admin_panel/src/ui/widgets/logo.dart';
import 'package:ob_admin_panel/src/ui/widgets/submit_button.dart';

import 'package:responsive_builder/responsive_builder.dart';

class RegisterPage extends StatelessWidget {
  static const routeName = '/register';
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return DesktopRegisterPage();
        } else
          return MobileRegisterPage();
      },
    );
  }
}

class DesktopRegisterPage extends StatefulWidget {
  @override
  _DesktopRegisterPageState createState() => _DesktopRegisterPageState();
}

class _DesktopRegisterPageState extends State<DesktopRegisterPage> {
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
                        CustomTextFormField(
                          label: ConstantTexts.CONFIRM_PASSWORD,
                          isPassword: true,
                          onSaved: () {},
                          validator: () {},
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, HomePage.routeName),
                          child: SubmitButton(),
                        ),
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

class MobileRegisterPage extends StatefulWidget {
  @override
  _MobileRegisterPageState createState() => _MobileRegisterPageState();
}

class _MobileRegisterPageState extends State<MobileRegisterPage> {
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
                MobileLogo(),
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
                        CustomTextFormField(
                          label: ConstantTexts.CONFIRM_PASSWORD,
                          isPassword: true,
                          onSaved: () {},
                          validator: () {},
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, HomePage.routeName),
                          child: SubmitButton(),
                        ),
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
