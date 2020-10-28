import 'package:flutter/cupertino.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';

import 'package:ob_admin_panel/src/ui/pages/register.dart';

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
        children: [
          Text(
            ConstantTexts.CREATE_ACCOUNT,
            style: TextStyle(
              color: const Color(
                ColorConstants.LOGIN_REGISTER_TEXT_COLOR,
              ),
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          Icon(
            CupertinoIcons.arrow_right,
            color: const Color(
              ColorConstants.LOGIN_REGISTER_TEXT_COLOR,
            ),
            size: 15,
          )
        ],
      ),
    );
  }
}
