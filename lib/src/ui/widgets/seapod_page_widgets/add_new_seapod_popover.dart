import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/constants/constant_texts.dart';

class AddNewSeapodPopover extends StatelessWidget {
  const AddNewSeapodPopover({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
      child: Dialog(
        backgroundColor:
            const Color(ColorConstants.loginRegisterTextColor).withOpacity(
          0.7,
        ),
        child: Container(
          height: 482,
          width: 370,
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 30.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  bottom: 30.0,
                ),
                child: Text(
                  ConstantTexts.addNewSeapod,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const AddNewSeapodRow(
                text: ConstantTexts.name,
              ),
              const AddNewSeapodRow(
                text: ConstantTexts.owner,
              ),
              const AddNewSeapodRow(
                text: ConstantTexts.type,
              ),
              const AddNewSeapodRow(
                text: ConstantTexts.location,
              ),
              const AddNewSeapodRow(
                text: ConstantTexts.status,
              ),
              const AddNewSeapodRow(
                text: ConstantTexts.accessLevel,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildContainer(
                        icon: CupertinoIcons.multiply,
                        text: ConstantTexts.delete),
                    buildContainer(
                      icon: CupertinoIcons.checkmark_alt,
                      text: ConstantTexts.save,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector buildContainer({
    @required IconData icon,
    @required String text,
  }) {
    return GestureDetector(
      child: Container(
        height: 42,
        width: 137,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.white,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 25.0,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              text.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddNewSeapodRow extends StatelessWidget {
  const AddNewSeapodRow({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: 219.0,
            height: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              color: Colors.white,
            ),
            child: const TextField(),
          )
        ],
      ),
    );
  }
}
