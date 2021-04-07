import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/helpers/size_calcs.dart';
import 'package:ob_admin_panel/src/models/field.dart';
import 'package:ob_admin_panel/src/ui/widgets/devices_page_widgets/devices_details_row.dart';

class MobileDevicesTable extends StatefulWidget {
  const MobileDevicesTable({
    @required this.columns,
  });

  final List<Field> columns;
  @override
  _MobileDevicesTableState createState() => _MobileDevicesTableState();
}

class _MobileDevicesTableState extends State<MobileDevicesTable> {
  List<Field> selectedColumns;
  @override
  Widget build(BuildContext context) {
    selectedColumns =
        widget.columns.where((element) => element.isChecked).toList();
    return Expanded(
      child: _getBodyWidget(),
    );
  }

  Widget _getBodyWidget() {
    return HorizontalDataTable(
      leftHandSideColumnWidth: 100,
      rightHandSideColumnWidth:
          (selectedColumns.length - 1) * Constants.tableFieldWidth,
      isFixedHeader: true,
      headerWidgets: _getTitleWidgets(),
      leftSideItemBuilder: _generateFirstColumnRow,
      rightSideItemBuilder: _generateRightHandSideColumnRow,
      itemCount: 5,
      leftHandSideColBackgroundColor:
          const Color(ColorConstants.categoryColumnBackground),
    );
  }

  List<Widget> _getTitleWidgets() {
    final List<Widget> widgets = [];
    widgets.add(
      _getTitleItemWidget(
        widget.columns[0],
        width: 100,
        backgroundColor: const Color(ColorConstants.categoryColumnBackground),
      ),
    );

    final columns = selectedColumns.sublist(1);

    for (final element in columns) {
      widgets.add(
        _getTitleItemWidget(element),
      );
    }
    return widgets;
  }

  Widget _getTitleItemWidget(
    Field field, {
    double width,
    Color backgroundColor = const Color(
      ColorConstants.seapodTableHeaderBackground,
    ),
  }) {
    return Container(
      width: width ?? Constants.tableFieldWidth,
      height: 55,
      color: backgroundColor,
      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
      child: Text(
        field.fieldName.toUpperCase(),
        textAlign: field.textAlign,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Color(
            ColorConstants.textColor,
          ),
        ),
      ),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      width: 100,
      height: DeviceTableSizeCalcs.calculateDeviceRowHeight(2, 2),
      alignment: Alignment.center,
      child: Center(
        child: Text(
          'Category$index',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(
              ColorConstants.textColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          DeviceDetailsRow(
            columns: widget.columns,
            isMobileView: true,
          ),
          const Divider(
            thickness: 2,
            color: Color(
              ColorConstants.tableViewDividerColor,
            ),
          ),
        ],
      ),
    );
  }
}
