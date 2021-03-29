import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/constants/constant_texts.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/helpers/fields_intializer.dart';
import 'package:ob_admin_panel/src/models/field.dart';
import 'package:ob_admin_panel/src/ui/widgets/add_button.dart';
import 'package:ob_admin_panel/src/ui/widgets/admin_panel_header.dart';
import 'package:ob_admin_panel/src/ui/widgets/devices_page_widgets/mobile_devices_table.dart';
import 'package:ob_admin_panel/src/ui/widgets/filter_bubble.dart';
import 'package:ob_admin_panel/src/ui/widgets/mobile_left_navigation_drawer.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';

class MobileDevicesPage extends StatefulWidget {
  @override
  _MobileDevicesPageState createState() => _MobileDevicesPageState();
}

class _MobileDevicesPageState extends State<MobileDevicesPage> {
  List<Field> columns = FieldsInitializer.devicesPageFields(
    isMobileView: true,
  );
  var _showFilterbubble = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const MobileLeftNavigationMenu(
        tappedMenuIndex: Constants.devicesViewIndex,
      ),
      drawerScrimColor: const Color(ColorConstants.drawerScrimColor),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                MobileHeader(
                  showFilterIcon: true,
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
                    children: const [
                      TabTitle(
                        ConstantTexts.devices,
                      ),
                      SizedBox(
                        width: 45,
                        child: AddButton(
                          height: 40,
                          iconSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MobileDevicesTable(
                  columns: columns,
                ),
              ],
            ),
            if (_showFilterbubble)
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.only(top: 50, right: 20.0),
                  height: 570,
                  child: FilterBubble(
                    fields: columns,
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
