import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/models/field.dart';
import 'package:ob_admin_panel/src/ui/widgets/devices_page_widgets/category_field.dart';
import 'package:ob_admin_panel/src/ui/widgets/table_header.dart';

class DevicesTableHeader extends StatelessWidget {
  const DevicesTableHeader({
    @required this.columns,
    @required this.isMobileView,
  });
  final bool isMobileView;
  final List<Field> columns;
  @override
  Widget build(BuildContext context) {
    return TableHeader(
      children: [
        if (!isMobileView)
          CategoryField(
            categoryField: columns[0],
          ),
        if (isMobileView)
          DeviceDetailsHeaderRow(
            columns: columns,
            isMobileView: true,
          ),
        if (!isMobileView)
          Expanded(
            flex: columns.length - 1,
            child: DeviceDetailsHeaderRow(
              columns: columns,
              isMobileView: false,
            ),
          )
      ],
    );
  }
}

class DeviceDetailsHeaderRow extends StatelessWidget {
  const DeviceDetailsHeaderRow({
    Key key,
    @required this.columns,
    @required this.isMobileView,
  }) : super(key: key);

  final List<Field> columns;
  final bool isMobileView;

  @override
  Widget build(BuildContext context) {
    final deviceField = columns[1];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (deviceField.isChecked)
          DeviceField(
            deviceField: deviceField,
          ),
        Expanded(
          flex: isMobileView ? columns.length - 1 : columns.length - 2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: tableFieldsList(),
          ),
        ),
      ],
    );
  }

  List<Widget> tableFieldsList() {
    final selectedColumns =
        columns.sublist(2).where((element) => element.isChecked).toList();
    final List<Widget> widgets = [];
    for (final element in selectedColumns) {
      widgets.add(
        TableHeaderField(
          text: element.fieldName,
          textColor: const Color(
            ColorConstants.textColor,
          ),
          textAlign: element.textAlign,
        ),
      );
    }
    return widgets;
  }
}

class DeviceField extends StatelessWidget {
  const DeviceField({
    Key key,
    @required this.deviceField,
  }) : super(key: key);

  final Field deviceField;

  @override
  Widget build(BuildContext context) {
    return TableHeaderField(
      text: deviceField.fieldName,
      textColor: const Color(
        ColorConstants.textColor,
      ),
      textAlign: deviceField.textAlign,
    );
  }
}
