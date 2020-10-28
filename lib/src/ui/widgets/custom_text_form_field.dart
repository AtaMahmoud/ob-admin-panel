import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';

import 'package:responsive_builder/responsive_builder.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final Function validator;
  final Function onSaved;
  final bool isPassword;
  final bool isEmail;
  final bool isPhone;

  CustomTextFormField({
    this.label,
    this.validator,
    this.onSaved,
    this.isPassword = false,
    this.isEmail = false,
    this.isPhone = false,
  });
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Container(
          width: sizingInformation.deviceScreenType ==
                      DeviceScreenType.desktop ||
                  sizingInformation.deviceScreenType == DeviceScreenType.tablet
              ? 340
              : mediaQuery.width * 0.85,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  label,
                  style: TextStyle(
                    color: const Color(
                      ColorConstants.LOGIN_REGISTER_TEXT_COLOR,
                    ),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                height: 45,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(ColorConstants.TEXT_FIELD_BORDER),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.only(
                    left: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: const Color(
                          ColorConstants.TEXT_FIELD_BORDER,
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
                    textAlignVertical: TextAlignVertical.bottom,
                    obscureText: isPassword,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: label,
                      hintStyle: TextStyle(
                        color: const Color(
                          ColorConstants.LOGIN_REGISTER_TEXT_COLOR,
                        ),
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
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
