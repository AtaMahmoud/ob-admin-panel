import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/ui/widgets/add_button.dart';
import 'package:speech_bubble/speech_bubble.dart';

class AddNewElement extends StatelessWidget {
  const AddNewElement({
    Key key,
    this.onTap,
   @required this.hintText,
  }) : super(key: key);

  final VoidCallback onTap;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: const AddButton(),
        ),
        const SizedBox(
          height: 6.0,
        ),
        SpeechBubble(
          nipLocation: NipLocation.TOP,
          color: const Color(
            ColorConstants.loginRegisterTextColor,
          ),
          width: 152.0,
          child: Center(
            child: Text(
              hintText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
          ),
        )
      ],
    );
  }
}
