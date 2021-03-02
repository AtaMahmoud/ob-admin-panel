import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/constants/constant_texts.dart';
import 'package:ob_admin_panel/src/models/field.dart';
import 'package:ob_admin_panel/src/ui/widgets/table_header.dart';
import 'package:ob_admin_panel/src/ui/widgets/users_page_widgets/user_table_content.dart';

class UsersTable extends StatefulWidget {
  @override
  _UsersTableState createState() => _UsersTableState();
}

class _UsersTableState extends State<UsersTable> {
  List<Field> columns = [
    Field(fieldName: ConstantTexts.name),
    Field(fieldName: ConstantTexts.seapod.toUpperCase()),
    Field(fieldName: ConstantTexts.memberSince),
    Field(fieldName: ConstantTexts.type),
    Field(
      fieldName: ConstantTexts.access.toUpperCase(),
    ),
    Field(fieldName: ConstantTexts.location),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableHeader(
          children: tableFieldsList(),
        ),
        UsersTableContent(
          columns: columns,
        ),
      ],
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
