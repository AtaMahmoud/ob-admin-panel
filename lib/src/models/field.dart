import 'package:flutter/cupertino.dart';

class Field {
  String fieldName;
  bool isChecked;

  Field({
    @required this.fieldName,
    this.isChecked = true,
  });
}
