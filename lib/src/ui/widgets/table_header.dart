import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';

class TableHeader extends StatelessWidget {
  final List<Widget> children;
  const TableHeader({@required this.children});
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
      child: Row(
        children: children,
      ),
    );
  }
}

class TableHeaderField extends StatelessWidget {
  const TableHeaderField({
    Key key,
    @required this.text,
    this.textColor = Colors.black,
  }) : super(key: key);

  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text.toUpperCase(),
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}
