import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/ui/widgets/table_field_content.dart';

class DevicesTableContent extends StatefulWidget {
  @override
  _DevicesTableContentState createState() => _DevicesTableContentState();
}

class _DevicesTableContentState extends State<DevicesTableContent> {
  @override
  Widget build(BuildContext context) {
    final customDivider = Container(
      height: 1,
      color: const Color(
        ColorConstants.tableViewDividerColor,
      ),
    );
    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 10.0,
              bottom: 10.0,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    //Category Column
                    TableFieldContent(
                      text: 'Category$index',
                    ),
                    Expanded(
                      flex: 12,
                      child: Column(
                        children: [
                          ...[
                            for (int i = 0; i < 2; i++) ...[
                              Row(
                                children: [
                                  //Device Column
                                  TableFieldContent(
                                    text: 'Device$i',
                                    color:
                                        const Color(ColorConstants.mainColor),
                                    textAlign: TextAlign.center,
                                  ),
                                  Expanded(
                                    flex: 11,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 50.0),
                                      child: Column(
                                        children: [
                                          ...[
                                            for (int j = 0; j < 2; j++) ...[
                                              Row(
                                                children: [
                                                  //Element Column
                                                  TableFieldContent(
                                                    text: 'Element$j',
                                                    color: const Color(
                                                        ColorConstants
                                                            .mainColor),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  //Product Column
                                                  const TableFieldContent(
                                                    text: 'Bosch,\nModel 6785',
                                                    color: Color(ColorConstants
                                                        .mainColor),
                                                  ),
                                                  //Life Span Column
                                                  const TableFieldContent(
                                                    text: '10 y',
                                                    color: Color(ColorConstants
                                                        .dateColor),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  //Maintanence Column
                                                  const TableFieldContent(
                                                    text: '6 mo',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  //Usage Start Date Column
                                                  const TableFieldContent(
                                                    text: '02/03/2021',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  //Maintanence Date Column
                                                  const TableFieldContent(
                                                    text: '02/03/2021',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  //Change Date Column
                                                  const TableFieldContent(
                                                    text: '02/03/2021',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  //Location Column
                                                  const TableFieldContent(
                                                    text:
                                                        'Boiler Room (1st Floor)',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  //Cost Column
                                                  const TableFieldContent(
                                                    text: '100 ',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  //Status Column
                                                  const TableFieldContent(
                                                    text: 'OK',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  //Importance Column
                                                  const TableFieldContent(
                                                    text: 'High',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
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
                      ),
                    ),
                  ],
                ),
                customDivider,
              ],
            ),
          );
        },
      ),
    );
  }
}
