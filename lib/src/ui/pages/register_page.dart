import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/models/admin.dart';
import 'package:ob_admin_panel/src/providers/admin_auth_provider.dart';
import 'package:ob_admin_panel/src/ui/pages/seapods_page/seapods_page.dart';
import 'package:ob_admin_panel/src/ui/widgets/custom_text_form_field.dart';
import 'package:ob_admin_panel/src/ui/widgets/logo.dart';
import 'package:ob_admin_panel/src/ui/widgets/submit_button.dart';
import 'package:provider/provider.dart';

import 'package:responsive_builder/responsive_builder.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = 'create-account';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final Admin _admin = Admin();
  String _password;
  String _confirmPassword;
  String _firstNameValidationText;
  String _lastNameValidationText;
  String _emailValidationText;
  String _passwordValidationText;
  String _confirmPasswordValidationText;
  String _mobileValidationText;
  String _countryValidationText;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final adminProvider = Provider.of<AdminAuthProvider>(context);
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Scaffold(
          backgroundColor: const Color(ColorConstants.loginContainerBackground),
          body: SafeArea(
            child: ListView(
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
                            height: mediaQuery.height * 0.08,
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
                              label: ConstantTexts.firstName,
                              validationText: _firstNameValidationText,
                              onSaved: (String value) {
                                _admin.firstName = value;
                              },
                              onTap: () {
                                setState(() {
                                  _firstNameValidationText = null;
                                });
                              },
                            ),
                            CustomTextFormField(
                              label: ConstantTexts.lastName,
                              validationText: _lastNameValidationText,
                              onSaved: (String value) {
                                _admin.lastName = value;
                              },
                              onTap: () {
                                setState(() {
                                  _lastNameValidationText = null;
                                });
                              },
                            ),
                            CustomTextFormField(
                              label: ConstantTexts.email.toUpperCase(),
                              validationText: _emailValidationText,
                              onSaved: (String value) {
                                _admin.email = value;
                              },
                              onTap: () {
                                setState(() {
                                  _emailValidationText = null;
                                });
                              },
                            ),
                            CustomTextFormField(
                              label: ConstantTexts.password,
                              validationText: _passwordValidationText,
                              isPassword: true,
                              onSaved: (String value) {
                                _password = value;
                              },
                              onTap: () {
                                setState(() {
                                  _passwordValidationText = null;
                                });
                              },
                            ),
                            CustomTextFormField(
                              label: ConstantTexts.confirmPassword,
                              validationText: _confirmPasswordValidationText,
                              isPassword: true,
                              onSaved: (String value) {
                                _confirmPassword = value;
                              },
                              onTap: () {
                                setState(() {
                                  _confirmPasswordValidationText = null;
                                });
                              },
                            ),
                            CustomTextFormField(
                              label: ConstantTexts.mobileNumber,
                              validationText: _mobileValidationText,
                              onSaved: (String value) {
                                _admin.mobileNumber = value;
                              },
                              onTap: () {
                                setState(() {
                                  _mobileValidationText = null;
                                });
                              },
                            ),
                            CustomTextFormField(
                              label: ConstantTexts.country,
                              validationText: _countryValidationText,
                              onSaved: (String value) {
                                _admin.country = value;
                              },
                              onTap: () {
                                setState(() {
                                  _countryValidationText = null;
                                });
                              },
                            ),
                            GestureDetector(
                              onTap: () async {
                                _formKey.currentState.save();
                                if (validateRegisterationForm()) {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const SpinKitFadingCircle(
                                      color: Color(ColorConstants.mainColor),
                                    ),
                                  );

                                  await adminProvider.register(
                                      _admin, _password);
                                  Navigator.of(context).pop();
                                  if (adminProvider.authenticatedAdmin !=
                                      null) {
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder:
                                            (context, animation1, animation2) =>
                                                SeapodsPage(),
                                        transitionDuration: const Duration(),
                                        settings: const RouteSettings(
                                          name: SeapodsPage.routeName,
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: SubmitButton(),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            CupertinoIcons.arrowtriangle_left_fill,
                            color: Color(
                              ColorConstants.loginRegisterTextColor,
                            ),
                            size: 15,
                          ),
                          Text(
                            ConstantTexts.login,
                            style: TextStyle(
                              color: Color(
                                ColorConstants.loginRegisterTextColor,
                              ),
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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

  bool validateRegisterationForm() {
    _firstNameValidationText = _lastNameValidationText = _emailValidationText =
        _passwordValidationText = _confirmPasswordValidationText =
            _mobileValidationText = _countryValidationText = null;
    if (_admin.firstName == null || _admin.firstName.isEmpty) {
      setState(() {
        _firstNameValidationText = 'Please provide your first name.';
      });
      return false;
    }
    if (_admin.lastName == null || _admin.lastName.isEmpty) {
      setState(() {
        _lastNameValidationText = 'Please provide your last name.';
      });
      return false;
    }
    if (_admin.email == null || _admin.email.isEmpty) {
      setState(() {
        _emailValidationText = 'Please provide your Email.';
      });
      return false;
    }
    if (!validateEmail()) {
      setState(() {
        _emailValidationText = 'Please provide a vaild Email';
      });
      return false;
    }
    if (_password == null || _password.isEmpty) {
      setState(() {
        _passwordValidationText = 'Please provide a password.';
      });
      return false;
    }
    if (!validatePassword()) {
      setState(() {
        _passwordValidationText = 'Please choose more secure password.';
      });
      return false;
    }
    if (_confirmPassword == null || _confirmPassword.isEmpty) {
      setState(() {
        _confirmPasswordValidationText = 'Please confirm your password.';
      });
      return false;
    }
    if (!_isPasswordConfirmed()) {
      setState(() {
        _confirmPasswordValidationText = 'Passwords don not match.';
      });
      return false;
    }
    if (_admin.mobileNumber == null || _admin.mobileNumber.isEmpty) {
      setState(() {
        _mobileValidationText = 'Please provide your mobile number.';
      });
      return false;
    }
    if (_admin.country == null || _admin.country.isEmpty) {
      setState(() {
        _countryValidationText = 'Please provide a country name.';
      });
      return false;
    }
    return true;
  }

  bool _isPasswordConfirmed() {
    return _confirmPassword == _password;
  }

  bool validatePassword() {
    final regExp = RegExp(
      r'^.*(?=.{8,})((?=.*[!@#$%^&*()\-_=+{};:,<.>]){1})(?=.*\d)((?=.*[a-z]){1})((?=.*[A-Z]){1}).*$',
    );
    return regExp.hasMatch(_password);
  }

  bool validateEmail() {
    final regExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    );
    return regExp.hasMatch(_admin.email);
  }
}
