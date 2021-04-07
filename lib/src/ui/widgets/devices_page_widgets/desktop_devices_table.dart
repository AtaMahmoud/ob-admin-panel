import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/models/field.dart';
import 'package:ob_admin_panel/src/ui/widgets/devices_page_widgets/devices_details_row.dart';
import 'package:ob_admin_panel/src/ui/widgets/devices_page_widgets/devices_field_content.dart';
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
  List<Field> selectedColumns;
  @override
  Widget build(BuildContext context) {
    selectedColumns =
        widget.columns.where((element) => element.isChecked).toList();
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: (selectedColumns.length * Constants.tableFieldWidth) + 40,
          child: Column(
            children: [
              TableHeader(
                children: tableFieldsList(),
              ),
              const SizedBox(
                height: 8.0,
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

  List<Widget> tableFieldsList() {
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Category Row
                  DevicesFieldContent(
                    text: 'Category$index',
                    visible: true,
                    textAlign: widget.columns[0].textAlign,
                  ),
                  Expanded(
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
