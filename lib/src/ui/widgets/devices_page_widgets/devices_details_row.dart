import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/models/field.dart';
import 'package:ob_admin_panel/src/ui/widgets/devices_page_widgets/devices_field_content.dart';
import 'package:ob_admin_panel/src/ui/widgets/table_field_content.dart';

class DeviceDetailsRow extends StatelessWidget {
  const DeviceDetailsRow({
    Key key,
    @required this.columns,
    @required this.isMobileView,
  }) : super(key: key);

  final List<Field> columns;
  final bool isMobileView;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...[
          for (int i = 0; i < 2; i++) ...[
            Row(
              children: [
                //Device Row
                DevicesFieldContent(
                  text: 'Device$i',
                  visible: columns[1].isChecked,
                  textAlign: columns[1].textAlign,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: Constants.elementsColumnBottomPadding,
                    ),
                    child: Column(
                      children: [
                        ...[
                          for (int j = 0; j < 2; j++) ...[
                            SizedBox(
                              height: Constants.elementRowHeight,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  //Element Row
                                  TableFieldContent(
                                    visible: columns[2].isChecked,
                                    text: 'Element$j',
                                    color:
                                        const Color(ColorConstants.mainColor),
                                    textAlign: columns[2].textAlign,
                                  ),
                                  //Product Row
                                  TableFieldContent(
                                    visible: columns[3].isChecked,
                                    text: 'Bosch,\nModel 6785',
                                    color:
                                        const Color(ColorConstants.mainColor),
                                  ),
                                  //Life Span Row
                                  TableFieldContent(
                                    visible: columns[4].isChecked,
                                    text: '10 y',
                                    color:
                                        const Color(ColorConstants.dateColor),
                                    textAlign: TextAlign.center,
                                  ),
                                  //Maintanence Row
                                  TableFieldContent(
                                    visible: columns[5].isChecked,
                                    text: '6 mo',
                                    textAlign: TextAlign.center,
                                  ),
                                  //Usage Start Date Row
                                  TableFieldContent(
                                    visible: columns[6].isChecked,
                                    text: '02/03/2021',
                                    textAlign: TextAlign.center,
                                  ),
                                  //Maintanence Date Row
                                  TableFieldContent(
                                    visible: columns[7].isChecked,
                                    text: '02/03/2021',
                                    textAlign: TextAlign.center,
                                  ),
                                  //Change Date Row
                                  TableFieldContent(
                                    visible: columns[8].isChecked,
                                    text: '02/03/2021',
                                    textAlign: TextAlign.center,
                                  ),
                                  //Location Row
                                  TableFieldContent(
                                    visible: columns[9].isChecked,
                                    text: 'Boiler Room (1st Floor)',
                                    textAlign: TextAlign.center,
                                  ),
                                  //Cost Row
                                  TableFieldContent(
                                    visible: columns[10].isChecked,
                                    text: '100 ',
                                    textAlign: TextAlign.center,
                                  ),
                                  //Status Row
                                  TableFieldContent(
                                    visible: columns[11].isChecked,
                                    text: 'OK',
                                    textAlign: TextAlign.center,
                                  ),
                                  //Importance Row
                                  TableFieldContent(
                                    visible: columns[12].isChecked,
                                    text: 'High',
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ]
                        ]
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]
        ]
      ],
    );
  }
}
