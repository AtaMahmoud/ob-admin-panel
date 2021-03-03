import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';

class TableHeader extends StatelessWidget {
  final List<Widget> children;
  const TableHeader({
    @required this.children,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(
        left: 20,
        right: 10,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
        color: Color(
          ColorConstants.seapodTableHeaderBackground,
        ),
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}

class TableHeaderField extends StatelessWidget {
  const TableHeaderField({
    Key key,
    @required this.text,
    this.textColor = Colors.black,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  final String text;
  final Color textColor;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text.toUpperCase(),
        textAlign: textAlign,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}
