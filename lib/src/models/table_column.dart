import 'package:flutter/cupertino.dart';

class SeapodTableColumn {
  String columnName;
  bool isChecked;

  SeapodTableColumn({
    @required this.columnName,
    this.isChecked = true,
  });
}
