import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/constants/constant_texts.dart';
import 'package:ob_admin_panel/src/models/field.dart';
import 'package:ob_admin_panel/src/ui/widgets/devices_page_widgets/devices_table_content.dart';
import 'package:ob_admin_panel/src/ui/widgets/table_header.dart';

class DevicesTable extends StatefulWidget {
  const DevicesTable({
    @required this.columns,
  });
  final List<Field> columns;
  @override
  _DevicesTableState createState() => _DevicesTableState();
}

class _DevicesTableState extends State<DevicesTable> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableHeader(
          children: [
            TableHeaderField(
              text: widget.columns[0].fieldName,
              textColor: const Color(
                ColorConstants.textColor,
              ),
              textAlign: widget.columns[0].textAlign,
            ),
            Expanded(
              flex: widget.columns.length - 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.columns[1].isChecked)
                    TableHeaderField(
                      text: widget.columns[1].fieldName,
                      textColor: const Color(
                        ColorConstants.textColor,
                      ),
                      textAlign: widget.columns[1].textAlign,
                    ),
                  Expanded(
                    flex: widget.columns.length - 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: tableFieldsList(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15.0,
        ),
        DevicesTableContent(
          columns: widget.columns,
        ),
      ],
    );
  }

  List<Widget> tableFieldsList() {
    final selectedColumns = widget.columns
        .where((element) =>
            element.isChecked &&
            element.fieldName != ConstantTexts.category &&
            element.fieldName != ConstantTexts.device)
        .toList();
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
