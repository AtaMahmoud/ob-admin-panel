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
    Field(fieldName: ConstantTexts.category),
    Field(fieldName: ConstantTexts.devices),
    Field(fieldName: ConstantTexts.element),
    Field(fieldName: ConstantTexts.product),
    Field(
      fieldName: ConstantTexts.lifeSpan,
    ),
    Field(fieldName: ConstantTexts.maintenance),
    Field(fieldName: ConstantTexts.usageStartDate),
    Field(fieldName: ConstantTexts.maintenanceDate),
    Field(fieldName: ConstantTexts.changeDate),
    Field(fieldName: ConstantTexts.location),
    Field(fieldName: ConstantTexts.cost),
    Field(fieldName: ConstantTexts.status),
    Field(fieldName: ConstantTexts.importance),
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
        ),
      );
    }
    return widgets;
  }
}
