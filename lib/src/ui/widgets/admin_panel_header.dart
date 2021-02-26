import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/providers/admin_auth_provider.dart';
import 'package:ob_admin_panel/src/ui/widgets/logo.dart';
import 'package:provider/provider.dart';

class DesktopHeader extends StatefulWidget {
  final void Function() onTap;
  final String selectedSeapodName;

  const DesktopHeader({
    @required this.onTap,
    this.selectedSeapodName,
  });

  @override
  _DesktopHeaderState createState() => _DesktopHeaderState();
}

class _DesktopHeaderState extends State<DesktopHeader> {
  @override
  Widget build(BuildContext context) {
    final admin = Provider.of<AdminAuthProvider>(
      context,
    ).authenticatedAdmin;

    return Container(
      padding: const EdgeInsets.only(right: 60),
      height: Constants.headerHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WebLogo(),
          Container(
            width: 400,
            margin: const EdgeInsets.only(
              top: 45,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 30,
                  width: 250,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(ColorConstants.textFieldBorder),
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
                          ImagePaths.searchIcon,
                          fit: BoxFit.contain,
                        ),
                      ),
                      hintText: ConstantTexts.search,
                      hintStyle: const TextStyle(
                        color: Color(
                          ColorConstants.loginRegisterTextColor,
                        ),
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Container(
                    width: 140,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color(
                        ColorConstants.loginRegisterTextColor,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: Text(
                        widget.selectedSeapodName ??
                            '${admin.firstName} ${admin.lastName}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MobileHeader extends StatelessWidget {
  final bool showLogo;
  final bool showFilterIcon;
  final VoidCallback onTappingFilterIcon;

  const MobileHeader({
    this.showLogo = true,
    this.showFilterIcon = false,
    this.onTappingFilterIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(
                builder: (
                  BuildContext context,
                ) =>
                    GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Image.asset(
                      ImagePaths.hamburgerMenu,
                      color: const Color(
                        ColorConstants.loginRegisterTextColor,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  if (showFilterIcon)
                    GestureDetector(
                      onTap: onTappingFilterIcon,
                      child: Image.asset(
                        ImagePaths.tableFilterIcon,
                        color: const Color(
                          ColorConstants.loginRegisterTextColor,
                        ),
                      ),
                    ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    ImagePaths.searchIcon,
                    fit: BoxFit.contain,
                    color: const Color(
                      ColorConstants.loginRegisterTextColor,
                    ),
                    width: 30,
                    height: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
        if (showLogo) MobileLogo(),
      ],
    );
  }
}
