import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/providers/admin_auth_provider.dart';
import 'package:ob_admin_panel/src/ui/pages/main_page.dart';
import 'package:ob_admin_panel/src/ui/widgets/create_account_button.dart';
import 'package:ob_admin_panel/src/ui/widgets/custom_text_form_field.dart';
import 'package:ob_admin_panel/src/ui/widgets/logo.dart';
import 'package:ob_admin_panel/src/ui/widgets/submit_button.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginPage extends StatefulWidget {
  static const routeName = 'login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var _adminProvider = Provider.of<AdminAuthProvider>(context);
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Scaffold(
          backgroundColor: Color(ColorConstants.LOGIN_CONTAINER_BACKGROUND),
          body: SafeArea(
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    sizingInformation.deviceScreenType ==
                            DeviceScreenType.desktop
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  WebLogo(),
                                ],
                              ),
                              SizedBox(
                                height: mediaQuery.height * 0.15,
                              ),
                            ],
                          )
                        : Column(
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
                            ],
                          ),
                    Container(
                      width: 342,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextFormField(
                              label: ConstantTexts.EMAIL,
                              onSaved: (String value) {
                                _email = value;
                              },
                            ),
                            CustomTextFormField(
                              label: ConstantTexts.PASSWORD,
                              isPassword: true,
                              onSaved: (String value) {
                                _password = value;
                              },
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
                              onTap: () async {
                                _formKey.currentState.save();
                                if (_email.isNotEmpty && _password.isNotEmpty)
                                  await loginProcess(context, _adminProvider);
                              },
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
      },
    );
  }

  Future loginProcess(
      BuildContext context, AdminAuthProvider _adminProvider) async {
    showDialog(
      context: context,
      builder: (context) => SpinKitFadingCircle(
        color: Color(ColorConstants.MAIN_COLOR),
        size: 50,
      ),
    );
    await _adminProvider.login(_email, _password);
    Navigator.of(context).pop();
    if (_adminProvider.authenticatedAdmin != null) {
      Navigator.pushReplacementNamed(context, MainPage.routeName);
    } /* else {
      onLoginFailed(context);
    } */
  }

  Future onLoginFailed(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Failure',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(ColorConstants.MAIN_COLOR),
          ),
        ),
        content: Text(
          'Invalid Email or Password',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(ColorConstants.MAIN_COLOR),
          ),
        ),
        actions: [
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Ok',
              style: TextStyle(
                color: Color(ColorConstants.MAIN_COLOR),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
