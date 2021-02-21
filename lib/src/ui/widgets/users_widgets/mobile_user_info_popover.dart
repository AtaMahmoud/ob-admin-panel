import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/ui/widgets/users_widgets/health_condition_details.dart';
import 'package:ob_admin_panel/src/ui/widgets/users_widgets/information_row.dart';
import 'package:ob_admin_panel/src/ui/widgets/users_widgets/user_info_list.dart';

class MobileUserInfoPopOver extends StatefulWidget {
  const MobileUserInfoPopOver({
    Key key,
  }) : super(key: key);

  @override
  _MobileUserInfoPopOverState createState() => _MobileUserInfoPopOverState();
}

class _MobileUserInfoPopOverState extends State<MobileUserInfoPopOver> {
  bool _showDetails = false;
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
      child: Dialog(
        insetPadding:
            const EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
        backgroundColor:
            const Color(ColorConstants.loginRegisterTextColor).withOpacity(0.8),
        child: Container(
          height: 500.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
          ),
          padding: const EdgeInsets.only(top: 30.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.0,
                    ),
                    child: Text(
                      'JOHN DOE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (_showDetails)
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        left: 15.0,
                      ),
                      child: InfoWidget(
                        info: ConstantTexts.healthCondition,
                      ),
                    ),
                  if (_showDetails) HealthConditionDetails(),
                  if (!_showDetails)
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: UserInfoList(
                        onDetailsButtonTapped: () {
                          setState(() {
                            _showDetails = true;
                          });
                        },
                      ),
                    ),
                ],
              ),
              if (_showDetails)
                BackButtonWidget(
                  onTap: () {
                    setState(() {
                      _showDetails = false;
                    });
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({Key key, @required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 90,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: const [
                RotatedBox(
                  quarterTurns: 3,
                  child: Icon(
                    Icons.arrow_drop_up,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                Text(
                  ConstantTexts.back,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
