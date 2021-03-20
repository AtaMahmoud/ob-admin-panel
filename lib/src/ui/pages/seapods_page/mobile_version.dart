import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/constants/constant_texts.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/helpers/api_response.dart';
import 'package:ob_admin_panel/src/helpers/fields_intializer.dart';
import 'package:ob_admin_panel/src/models/field.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/widgets/admin_panel_header.dart';
import 'package:ob_admin_panel/src/ui/widgets/filter_bubble.dart';
import 'package:ob_admin_panel/src/ui/widgets/seapod_page_widgets/map_tab.dart';
import 'package:ob_admin_panel/src/ui/widgets/mobile_left_navigation_drawer.dart';
import 'package:ob_admin_panel/src/ui/widgets/seapod_page_widgets/mobile_seapods_view.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class MobileSeapodsPage extends StatefulWidget {
  final int seapodsViewIndex;
  final VoidCallback onMapTap;
  final VoidCallback onListTap;

  const MobileSeapodsPage({
    @required this.seapodsViewIndex,
    @required this.onMapTap,
    @required this.onListTap,
  });
  @override
  _MobileSeapodsPageState createState() => _MobileSeapodsPageState();
}

class _MobileSeapodsPageState extends State<MobileSeapodsPage>
    with SingleTickerProviderStateMixin {
  var _isInit = true;
  var _showFilterbubble = false;
  SeaPodsProvider seaPodsProvider;
  List<Field> fields = FieldsInitializer.seapodPageFields();

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      seaPodsProvider = Provider.of<SeaPodsProvider>(
        context,
        listen: false,
      );
      await seaPodsProvider.getAllSeapods();
      setState(() {});
      _isInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    const _textStyle = TextStyle(
      color: Color(0xFF043D8D),
      fontSize: 18,
      fontWeight: FontWeight.w700,
    );
    final allSeapods = seaPodsProvider.allSeaPods;
    return Scaffold(
      drawer: const MobileLeftNavigationMenu(
        tappedMenuIndex: Constants.homeIndex,
      ),
      drawerScrimColor: const Color(ColorConstants.drawerScrimColor),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                MobileHeader(
                  showFilterIcon:
                      widget.seapodsViewIndex == Constants.seapodsListIndex,
                  onTappingFilterIcon: () {
                    setState(() {
                      _showFilterbubble = !_showFilterbubble;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TabTitle(
                        ConstantTexts.seapods,
                      ),
                      SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: widget.onMapTap,
                              child: const Text(
                                ConstantTexts.map,
                                style: _textStyle,
                              ),
                            ),
                            const Text(
                              '|',
                              style: _textStyle,
                            ),
                            GestureDetector(
                              onTap: widget.onListTap,
                              child: const Text(
                                ConstantTexts.list,
                                style: _textStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (allSeapods.status == Status.loading ||
                    allSeapods.data == null)
                  const SizedBox(
                    height: 300,
                    child: SpinKitFadingCircle(
                      color: Color(ColorConstants.mainColor),
                    ),
                  ),
                if (allSeapods.status == Status.completed &&
                    allSeapods.data != null)
                  Expanded(
                    child: IndexedStack(
                      index: widget.seapodsViewIndex,
                      children: [
                        MobileSeapodsView(
                          allSeapods: allSeapods.data,
                          fields: fields,
                        ),
                        MapTab(
                          seapods: allSeapods.data,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            if (_showFilterbubble)
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.only(top: 50, right: 20.0),
                  height: 320,
                  child: FilterBubble(
                    fields: fields,
                    applyFilter: () {
                      setState(() {});
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
