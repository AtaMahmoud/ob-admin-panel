import 'package:flutter/material.dart';

class Field {
  String fieldName;
  TextAlign textAlign;
  bool isChecked;

  Field({
    @required this.fieldName,
    this.isChecked = true,
    this.textAlign = TextAlign.start,
  });
}
