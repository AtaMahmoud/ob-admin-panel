import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/models/table_column.dart';
import 'package:ob_admin_panel/src/ui/widgets/desktop_main_view.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';
import 'package:ob_admin_panel/src/ui/widgets/table_header.dart';
import 'package:ob_admin_panel/src/ui/widgets/user_table_content.dart';

class DesktopUsersPage extends StatefulWidget {
  @override
  _DesktopLocationsPageState createState() => _DesktopLocationsPageState();
}

class _DesktopLocationsPageState extends State<DesktopUsersPage> {
  List<TableColumn> columns = [
    TableColumn(columnName: ConstantTexts.name),
    TableColumn(columnName: ConstantTexts.seapod),
    TableColumn(columnName: ConstantTexts.memberSince),
    TableColumn(columnName: ConstantTexts.type),
    TableColumn(columnName: ConstantTexts.access),
    TableColumn(columnName: ConstantTexts.location),
  ];
  @override
  Widget build(BuildContext context) {
    return DesktopMainView(
      viewIndex: Constants.usersViewIndex,
      view: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 35,
          top: 25,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 50,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TabTitle(
                    ConstantTexts.users,
                  ),
                  Image.asset(
                    ImagePaths.tableFilterIcon,
                  )
                ],
              ),
            ),
            TableHeader(
              children: tableFieldsList(),
            ),
            UsersTableContent(columns: columns),
          ],
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
