import 'package:flutter/material.dart';

class Field {
  String fieldName;
  bool isChecked;

  Field({
    @required this.fieldName,
    this.isChecked = true,
  });
}
