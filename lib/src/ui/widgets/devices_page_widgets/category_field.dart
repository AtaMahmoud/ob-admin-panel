import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/models/field.dart';
import 'package:ob_admin_panel/src/ui/widgets/table_header.dart';

class CategoryField extends StatelessWidget {
  const CategoryField({
    Key key,
    @required this.categoryField,
  }) : super(key: key);

  final Field categoryField;

  @override
  Widget build(BuildContext context) {
    return TableHeaderField(
      text: categoryField.fieldName,
      textColor: const Color(
        ColorConstants.textColor,
      ),
      textAlign: categoryField.textAlign,
    );
  }
}