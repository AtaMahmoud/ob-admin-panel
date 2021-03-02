import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/constants/constant_texts.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/helpers/size_calcs.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/widgets/desktop_main_view.dart';
import 'package:ob_admin_panel/src/ui/widgets/seapod_page_widgets/map_tab.dart';
import 'package:ob_admin_panel/src/ui/widgets/seapod_page_widgets/desktop_seapods_view.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';
import 'package:provider/provider.dart';

class DesktopSeapodsPage extends StatefulWidget {
  final int seapodsViewIndex;
  final VoidCallback onMapTap;
  final VoidCallback onListTap;

  const DesktopSeapodsPage({
    @required this.seapodsViewIndex,
    @required this.onMapTap,
    @required this.onListTap,
  });

  @override
  _DesktopSeapodsPageState createState() => _DesktopSeapodsPageState();
}

class _DesktopSeapodsPageState extends State<DesktopSeapodsPage> {
  var _isInit = true;
  var _isLoading = false;
  SeaPodsProvider seaPodsProvider;

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      seaPodsProvider = Provider.of<SeaPodsProvider>(
        context,
        listen: false,
      );
      await seaPodsProvider.getAllSeapods();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final allSeapods = seaPodsProvider.allSeaPods.data;
    final sizeCalcs = SizeCalcs(context: context);
    final tabViewWidth = sizeCalcs.calculateTabViewWidth();
    return DesktopMainView(
      viewIndex: Constants.homeIndex,
      view: Container(
        color: Color(
          widget.seapodsViewIndex == Constants.seapodsMapIndex
              ? ColorConstants.mabBackground
              : ColorConstants.tabBackground,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 30,
                top: 25,
              ),
              height: 75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TabTitle(
                    ConstantTexts.seapods,
                  ),
                  SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        switchSeapodViews(
                          widget.onMapTap,
                          ConstantTexts.map,
                          BoxDecoration(
                            color: Color(
                              widget.seapodsViewIndex ==
                                      Constants.seapodsMapIndex
                                  ? ColorConstants.switcherColor
                                  : ColorConstants.loginRegisterTextColor,
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            ),
                          ),
                        ),
                        Container(
                          width: 1,
                          color: Colors.white,
                        ),
                        switchSeapodViews(
                          widget.onListTap,
                          ConstantTexts.list,
                          BoxDecoration(
                            color: Color(
                              widget.seapodsViewIndex ==
                                      Constants.seapodsListIndex
                                  ? ColorConstants.switcherColor
                                  : ColorConstants.loginRegisterTextColor,
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (widget.seapodsViewIndex == Constants.seapodsListIndex)
              DesktopSeapodsView(),
            if (!_isLoading && widget.seapodsViewIndex == Constants.seapodsMapIndex)
              Container(
                margin: EdgeInsets.only(right: tabViewWidth * 0.1),
                height: 650,
                child: MapTab(
                  seapods: allSeapods,
                ),
              ),
          ],
        ),
      ),
    );
  }

  GestureDetector switchSeapodViews(
    void Function() onTap,
    String text,
    BoxDecoration decoration,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: decoration,
        width: 80,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
