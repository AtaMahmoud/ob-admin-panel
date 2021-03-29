import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/models/field.dart';
import 'package:ob_admin_panel/src/ui/widgets/devices_page_widgets/devices_details_row.dart';
import 'package:ob_admin_panel/src/ui/widgets/table_field_content.dart';
import 'package:ob_admin_panel/src/ui/widgets/table_header.dart';

class DesktopDevicesTable extends StatefulWidget {
  const DesktopDevicesTable({
    @required this.columns,
  });

  final List<Field> columns;

  @override
  _DesktopDevicesTableState createState() => _DesktopDevicesTableState();
}

class _DesktopDevicesTableState extends State<DesktopDevicesTable> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 1780.0,
          child: Column(
            children: [
              _DevicesTableHeader(
                columns: widget.columns,
              ),
              const SizedBox(
                height: 15.0,
              ),
              SizedBox(
                height: 500,
                child: DevicesTableContent(
                  columns: widget.columns,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DevicesTableHeader extends StatelessWidget {
  const _DevicesTableHeader({
    @required this.columns,
  });
  final List<Field> columns;
  @override
  Widget build(BuildContext context) {
    return TableHeader(
      children: [
        _CategoryField(
          categoryField: columns[0],
        ),
        Expanded(
          flex: columns.length - 1,
          child: _DeviceDetailsHeaderRow(
            columns: columns,
          ),
        )
      ],
    );
  }
}

class _CategoryField extends StatelessWidget {
  const _CategoryField({
    Key key,
    @required this.categoryField,
  }) : super(key: key);

  final Field categoryField;

  @override
  Widget build(BuildContext context) {
    return TableHeaderField(
      text: categoryField.fieldName,
      textColor: const Color(
        ColorConstants.textColor,
      ),
      textAlign: categoryField.textAlign,
    );
  }
}

class _DeviceDetailsHeaderRow extends StatelessWidget {
  const _DeviceDetailsHeaderRow({
    Key key,
    @required this.columns,
  }) : super(key: key);

  final List<Field> columns;

  @override
  Widget build(BuildContext context) {
    final deviceField = columns[1];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DeviceField(
          visible: deviceField.isChecked,
          deviceField: deviceField,
        ),
        Expanded(
          flex: columns.length - 2,
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
    @required this.visible,
  }) : super(key: key);

  final Field deviceField;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: TableHeaderField(
        text: deviceField.fieldName,
        textColor: const Color(
          ColorConstants.textColor,
        ),
        textAlign: deviceField.textAlign,
      ),
    );
  }
}

class DevicesTableContent extends StatefulWidget {
  const DevicesTableContent({
    @required this.columns,
  });

  final List<Field> columns;

  @override
  _DevicesTableContentState createState() => _DevicesTableContentState();
}

class _DevicesTableContentState extends State<DevicesTableContent> {
  @override
  Widget build(BuildContext context) {
    const customDivider = Divider(
      thickness: 2,
      color: Color(
        ColorConstants.tableViewDividerColor,
      ),
    );
    const itemCount = 10;
    return ListView.builder(
      itemCount: itemCount,
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
                  //Category Row
                  TableFieldContent(
                    text: 'Category$index',
                    visible: true,
                  ),
                  Expanded(
                    flex: widget.columns.length - 1,
                    child: DeviceDetailsRow(
                      columns: widget.columns,
                      isMobileView: false,
                    ),
                  ),
                ],
              ),
              if (index != itemCount - 1) customDivider,
            ],
          ),
        );
      },
    );
  }
}
