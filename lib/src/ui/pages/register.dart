import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/models/admin.dart';
import 'package:ob_admin_panel/src/providers/admin_auth_provider.dart';
import 'package:ob_admin_panel/src/ui/pages/login.dart';
import 'package:ob_admin_panel/src/ui/pages/main_page.dart';
import 'package:ob_admin_panel/src/ui/widgets/custom_text_form_field.dart';
import 'package:ob_admin_panel/src/ui/widgets/logo.dart';
import 'package:ob_admin_panel/src/ui/widgets/submit_button.dart';
import 'package:provider/provider.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:speech_bubble/speech_bubble.dart';

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
  var _firstNameValidationText;
  var _lastNameValidationText;
  var _emailValidationText;
  var _passwordValidationText;
  var _confirmPasswordValidationText;
  var _mobileValidationText;
  var _countryValidationText;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var adminProvider = Provider.of<AdminAuthProvider>(context);
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Scaffold(
          backgroundColor: Color(ColorConstants.LOGIN_CONTAINER_BACKGROUND),
          body: SafeArea(
            child: ListView(
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
                                height: mediaQuery.height * 0.08,
                              ),
                            ],
                          )
                        : Column(
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
                    Container(
                      width: 342,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextFormField(
                              label: ConstantTexts.FIRST_NAME,
                              validationText: _firstNameValidationText,
                              onSaved: (String value) {
                                _admin.firstName = value;
                              },
                            ),
                            CustomTextFormField(
                              label: ConstantTexts.LAST_NAME,
                              validationText: _lastNameValidationText,
                              onSaved: (String value) {
                                _admin.lastName = value;
                              },
                            ),
                            CustomTextFormField(
                              label: ConstantTexts.EMAIL,
                              validationText: _emailValidationText,
                              onSaved: (String value) {
                                _admin.email = value;
                              },
                            ),
                            CustomTextFormField(
                              label: ConstantTexts.PASSWORD,
                              validationText: _passwordValidationText,
                              isPassword: true,
                              onSaved: (String value) {
                                _password = value;
                              },
                            ),
                            CustomTextFormField(
                              label: ConstantTexts.CONFIRM_PASSWORD,
                              validationText: _confirmPasswordValidationText,
                              isPassword: true,
                              onSaved: (String value) {
                                _confirmPassword = value;
                              },
                            ),
                            CustomTextFormField(
                              label: ConstantTexts.MOBILE_NUMBER,
                              validationText: _mobileValidationText,
                              onSaved: (String value) {
                                _admin.mobileNumber = value;
                              },
                            ),
                            CustomTextFormField(
                              label: ConstantTexts.COUNTRY,
                              validationText: _countryValidationText,
                              onSaved: (String value) {
                                _admin.country = value;
                              },
                            ),
                            GestureDetector(
                              onTap: () async {
                                _formKey.currentState.save();
                                if (validateRegisterationForm()) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => SpinKitFadingCircle(
                                      color: Color(ColorConstants.MAIN_COLOR),
                                      size: 50,
                                    ),
                                  );

                                  await adminProvider.register(
                                      _admin, _password);
                                  Navigator.of(context).pop();
                                  if (adminProvider.authenticatedAdmin !=
                                      null) {
                                    Navigator.pushReplacementNamed(
                                        context, HomePage.routeName);
                                  }
                                }
                              },
                              child: SubmitButton(),
                            ),
                            SizedBox(
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
                        children: [
                          Icon(
                            CupertinoIcons.arrow_left,
                            color: const Color(
                              ColorConstants.LOGIN_REGISTER_TEXT_COLOR,
                            ),
                            size: 15,
                          ),
                          Text(
                            ConstantTexts.LOGIN,
                            style: TextStyle(
                              color: const Color(
                                ColorConstants.LOGIN_REGISTER_TEXT_COLOR,
                              ),
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
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
    var regExp = RegExp(
      r'^.*(?=.{8,})((?=.*[!@#$%^&*()\-_=+{};:,<.>]){1})(?=.*\d)((?=.*[a-z]){1})((?=.*[A-Z]){1}).*$',
    );
    return regExp.hasMatch(_password);
  }

  bool validateEmail() {
    var regExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    );
    return regExp.hasMatch(_admin.email);
  }
}
