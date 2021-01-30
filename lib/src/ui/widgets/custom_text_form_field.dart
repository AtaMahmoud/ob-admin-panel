import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:speech_bubble/speech_bubble.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final void Function(String) onSaved;
  final bool isPassword;
  final bool isEmail;
  final bool isPhone;
  final String validationText;
  final VoidCallback onTap;

  const CustomTextFormField({
    this.label,
    this.onSaved,
    this.isPassword = false,
    this.isEmail = false,
    this.isPhone = false,
    this.validationText,
    this.onTap,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return SizedBox(
          width: sizingInformation.deviceScreenType ==
                      DeviceScreenType.desktop ||
                  sizingInformation.deviceScreenType == DeviceScreenType.tablet
              ? 342
              : mediaQuery.width * 0.85,
          height: widget.validationText != null ? 150 : 100,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.label,
                      style: const TextStyle(
                        color: Color(
                          ColorConstants.loginRegisterTextColor,
                        ),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 52,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(ColorConstants.textFieldBorder),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 8,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Color(
                              ColorConstants.textFieldBorder,
                            ),
                          ),
                        ),
                        /* boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.0056),
                            blurRadius: 2.21,
                            offset: Offset(0, 2.77),
                          ),
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.0081),
                            blurRadius: 5.32,
                            offset: Offset(0, 6.65),
                          ),
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.01),
                            blurRadius: 10.02,
                            offset: Offset(0, 12.52),
                          ),
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.0119),
                            blurRadius: 17.87,
                            offset: Offset(0, 22.34),
                          ),
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.0144),
                            blurRadius: 33.42,
                            offset: Offset(0, 41.78),
                          ),
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.02),
                            blurRadius: 80,
                            offset: Offset(0, 100),
                          ),
                        ], */
                      ),
                      child: TextFormField(
                        onSaved: widget.onSaved,
                        onTap: widget.onTap,
                        textAlignVertical: TextAlignVertical.center,
                        obscureText: widget.isPassword,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.label,
                          hintStyle: const TextStyle(
                            color: Color(
                              ColorConstants.loginRegisterTextColor,
                            ),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (widget.validationText != null)
                Positioned(
                  top: 75,
                  left: 10,
                  child: SpeechBubble(
                    nipHeight: 15,
                    height: 60,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 15,
                    ),
                    color: const Color(
                      ColorConstants.loginRegisterTextColor,
                    ),
                    nipLocation: NipLocation.TOP_LEFT,
                    offset: const Offset(25.0, 0.0),
                    child: Text(
                      widget.validationText,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
