import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/constants/constant_texts.dart';
import 'package:ob_admin_panel/src/models/field.dart';
import 'package:ob_admin_panel/src/ui/widgets/devices_page_widgets/devices_table_content.dart';
import 'package:ob_admin_panel/src/ui/widgets/table_header.dart';

class DevicesTable extends StatefulWidget {
  @override
  _DevicesTableState createState() => _DevicesTableState();
}

class _DevicesTableState extends State<DevicesTable> {
  List<Field> columns = [
    Field(
      fieldName: ConstantTexts.category,
    ),
    Field(fieldName: ConstantTexts.devices, textAlign: TextAlign.center),
    Field(fieldName: ConstantTexts.element, textAlign: TextAlign.center),
    Field(fieldName: ConstantTexts.product),
    Field(fieldName: ConstantTexts.lifeSpan, textAlign: TextAlign.center),
    Field(fieldName: ConstantTexts.maintenance, textAlign: TextAlign.center),
    Field(fieldName: ConstantTexts.usageStartDate, textAlign: TextAlign.center),
    Field(
        fieldName: ConstantTexts.maintenanceDate, textAlign: TextAlign.center),
    Field(fieldName: ConstantTexts.changeDate, textAlign: TextAlign.center),
    Field(fieldName: ConstantTexts.location, textAlign: TextAlign.center),
    Field(fieldName: ConstantTexts.cost, textAlign: TextAlign.center),
    Field(fieldName: ConstantTexts.status, textAlign: TextAlign.center),
    Field(fieldName: ConstantTexts.importance, textAlign: TextAlign.center),
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 1750.0,
          child: Column(
            children: [
              TableHeader(
                children: tableFieldsList(),
              ),
              const SizedBox(
                height: 15.0,
              ),
              DevicesTableContent(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> tableFieldsList() {
    final selectedColumns =
        columns.where((element) => element.isChecked).toList();
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
