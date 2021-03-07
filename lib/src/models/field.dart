import 'package:flutter/material.dart';

class Field {
  String fieldName;
  TextAlign textAlign;
  bool isChecked;
  bool isFixed;

  Field({
    @required this.fieldName,
    this.isChecked = true,
    this.isFixed = false,
    this.textAlign = TextAlign.start,
  });
}
