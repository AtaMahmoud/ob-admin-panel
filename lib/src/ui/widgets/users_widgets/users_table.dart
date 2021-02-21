import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/models/table_column.dart';
import 'package:ob_admin_panel/src/ui/widgets/table_header.dart';
import 'package:ob_admin_panel/src/ui/widgets/users_widgets/user_table_content.dart';

class UsersTable extends StatefulWidget {
  @override
  _UsersTableState createState() => _UsersTableState();
}

class _UsersTableState extends State<UsersTable> {
  List<TableColumn> columns = [
    TableColumn(columnName: ConstantTexts.name),
    TableColumn(columnName: ConstantTexts.seapod.toUpperCase()),
    TableColumn(columnName: ConstantTexts.memberSince),
    TableColumn(columnName: ConstantTexts.type),
    TableColumn(
      columnName: ConstantTexts.access.toUpperCase(),
    ),
    TableColumn(columnName: ConstantTexts.location),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableHeader(
          children: tableFieldsList(),
        ),
        UsersTableContent(columns: columns),
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
          text: element.columnName,
          textColor: const Color(
            ColorConstants.textColor,
          ),
        ),
      );
    }
    return widgets;
  }
}
