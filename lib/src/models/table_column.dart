import 'package:flutter/cupertino.dart';

class TableColumn {
  String columnName;
  bool isChecked;

  TableColumn({
    @required this.columnName,
    this.isChecked = true,
  });
}
