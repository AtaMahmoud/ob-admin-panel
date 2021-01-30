import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/providers/admin_auth_provider.dart';
import 'package:ob_admin_panel/src/ui/pages/seapods_page/seapods_page.dart';
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
    final mediaQuery = MediaQuery.of(context).size;
    final _adminProvider = Provider.of<AdminAuthProvider>(context);
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Scaffold(
          backgroundColor: const Color(ColorConstants.loginContainerBackground),
          body: SafeArea(
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    if (sizingInformation.deviceScreenType ==
                        DeviceScreenType.desktop)
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
                        ],
                      ),
                    if (sizingInformation.deviceScreenType ==
                            DeviceScreenType.mobile ||
                        sizingInformation.deviceScreenType ==
                            DeviceScreenType.tablet)
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
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
                    SizedBox(
                      width: 342,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextFormField(
                              label: ConstantTexts.email.toUpperCase(),
                              onSaved: (String value) {
                                _email = value;
                              },
                            ),
                            CustomTextFormField(
                              label: ConstantTexts.password,
                              isPassword: true,
                              onSaved: (String value) {
                                _password = value;
                              },
                            ),
                            const Text(
                              ConstantTexts.forgotPassword,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Color(
                                  ColorConstants.mainColor,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 27,
                            ),
                            GestureDetector(
                              onTap: () async {
                                _formKey.currentState.save();
                                if (_email.isNotEmpty && _password.isNotEmpty) {
                                  await loginProcess(context, _adminProvider);
                                }
                              },
                              child: SubmitButton(),
                            ),
                            const SizedBox(
                              height: 27,
                            ),
                            const CreateAccountButton()
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
      builder: (context) => const SpinKitFadingCircle(
        color: Color(ColorConstants.mainColor),
      ),
    );
    await _adminProvider.login(_email, _password);
    Navigator.of(context).pop();
    if (_adminProvider.authenticatedAdmin != null) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>  SeapodsPage(),
          transitionDuration: const Duration(),
          settings: const RouteSettings(name: SeapodsPage.routeName),
        ),
      );
    } else {
      onLoginFailed(context);
    }
  }

  Future onLoginFailed(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Failure',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(ColorConstants.mainColor),
          ),
        ),
        content: const Text(
          'Invalid Email or Password',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(ColorConstants.mainColor),
          ),
        ),
        actions: [
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Ok',
              style: TextStyle(
                color: Color(ColorConstants.mainColor),
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
