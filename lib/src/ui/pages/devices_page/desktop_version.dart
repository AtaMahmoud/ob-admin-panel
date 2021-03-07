import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/constants/constant_texts.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/models/field.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/widgets/add_new_element.dart';
import 'package:ob_admin_panel/src/ui/widgets/desktop_main_view.dart';
import 'package:ob_admin_panel/src/ui/widgets/devices_page_widgets/devices_table.dart';
import 'package:ob_admin_panel/src/ui/widgets/filter_bubble.dart';
import 'package:ob_admin_panel/src/ui/widgets/filter_icon.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';
import 'package:provider/provider.dart';

class DesktopDevicesPage extends StatefulWidget {
  @override
  _DesktopDevicesPageState createState() => _DesktopDevicesPageState();
}

class _DesktopDevicesPageState extends State<DesktopDevicesPage> {
  bool _showFilterBubble = false;

  @override
  Widget build(BuildContext context) {
    final _selectedSeapod =
        Provider.of<SeaPodsProvider>(context).selectedSeapod;
    return DesktopMainView(
      selectedSeapodName: _selectedSeapod.seaPodName,
      viewIndex: Constants.devicesViewIndex,
      view: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          top: 25,
          right: 35.0,
          bottom: 30.0,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DevicesHeader(),
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0, top: 20.0),
                      child: FilterIcon(
                        onTap: () {
                          setState(() {
                            _showFilterBubble = !_showFilterBubble;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                DevicesTable(
                  columns: columns,
                ),

                //Add new device
                const AddNewElement(
                  hintText: ConstantTexts.addNewDevice,
                ),
              ],
            ),
            if (_showFilterBubble)
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.only(top: 55.0),
                  height: 480,
                  child: FilterBubble(
                    fields: columns,
                    applyFilter: () {
                      setState(() {});
                    },
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  List<Field> columns = [
    Field(fieldName: ConstantTexts.category, isFixed: true),
    Field(
      fieldName: ConstantTexts.device,
      textAlign: TextAlign.center,
    ),
    Field(
      fieldName: ConstantTexts.element,
      textAlign: TextAlign.center,
    ),
    Field(
      fieldName: ConstantTexts.product,
    ),
    Field(
      fieldName: ConstantTexts.lifeSpan,
      textAlign: TextAlign.center,
    ),
    Field(
      fieldName: ConstantTexts.maintenance,
      textAlign: TextAlign.center,
    ),
    Field(
      fieldName: ConstantTexts.usageStartDate,
      textAlign: TextAlign.center,
    ),
    Field(
      fieldName: ConstantTexts.maintenanceDate,
      textAlign: TextAlign.center,
    ),
    Field(
      fieldName: ConstantTexts.changeDate,
      textAlign: TextAlign.center,
    ),
    Field(
      fieldName: ConstantTexts.location,
      textAlign: TextAlign.center,
    ),
    Field(
      fieldName: ConstantTexts.cost,
      textAlign: TextAlign.center,
    ),
    Field(
      fieldName: ConstantTexts.status,
      textAlign: TextAlign.center,
    ),
    Field(
      fieldName: ConstantTexts.importance,
      textAlign: TextAlign.center,
    ),
  ];
}

class DevicesHeader extends StatelessWidget {
  const DevicesHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _selectedSeapod =
        Provider.of<SeaPodsProvider>(context).selectedSeapod;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TabTitle(ConstantTexts.devices),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 30),
          child: Text(
            '${ConstantTexts.seapod.toUpperCase()}  /  ${_selectedSeapod.seaPodName}  /  ${ConstantTexts.devices}'
                .toUpperCase(),
            style: const TextStyle(
              color: Color(ColorConstants.mainColor),
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
