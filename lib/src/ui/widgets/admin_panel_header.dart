import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/ui/widgets/logo.dart';

class DesktopHeader extends StatefulWidget {
  final Function showControlOptions;

  DesktopHeader({
    @required this.showControlOptions,
  });

  @override
  _DesktopHeaderState createState() => _DesktopHeaderState();
}

class _DesktopHeaderState extends State<DesktopHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 60),
      height: Constants.HEADER_HEIGHT,
      child: Column(
        children: [
          Container(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WebLogo(),
                Container(
                  width: 380,
                  margin: EdgeInsets.only(
                    top: 45,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 30,
                        width: 250,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color:
                                const Color(ColorConstants.TEXT_FIELD_BORDER),
                          ),
                        ),
                        child: TextField(
                          textAlign: TextAlign.right,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: SizedBox(
                              width: 15,
                              height: 15,
                              child: Image.asset(
                                ImagePaths.SEARCH_ICON,
                                fit: BoxFit.contain,
                              ),
                            ),
                            hintText: ConstantTexts.SEARCH,
                            hintStyle: TextStyle(
                              color: const Color(
                                ColorConstants.LOGIN_REGISTER_TEXT_COLOR,
                              ),
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.showControlOptions,
                        child: Container(
                          width: 120,
                          height: 30,
                          decoration: BoxDecoration(
                            color:
                                Color(ColorConstants.LOGIN_REGISTER_TEXT_COLOR),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Center(
                            child: Text(
                              'Shimaa Ismail',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w100),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MobileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(
                builder: (
                  BuildContext context,
                ) =>
                    IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Color(ColorConstants.LOGIN_REGISTER_TEXT_COLOR),
                    size: 35.0,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
              Image.asset(
                ImagePaths.SEARCH_ICON,
                fit: BoxFit.contain,
                width: 30,
                height: 30,
              ),
            ],
          ),
        ),
        MobileLogo(),
      ],
    );
  }
}
