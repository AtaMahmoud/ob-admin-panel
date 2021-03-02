import 'package:flutter/cupertino.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/constants/constant_texts.dart';

import 'package:ob_admin_panel/src/ui/pages/register_page.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(RegisterPage.routeName),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            ConstantTexts.createAccount,
            style: TextStyle(
              color: Color(
                ColorConstants.loginRegisterTextColor,
              ),
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          Icon(
            CupertinoIcons.arrowtriangle_right_fill,
            color: Color(
              ColorConstants.loginRegisterTextColor,
            ),
            size: 15,
          )
        ],
      ),
    );
  }
}
