import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/models/field.dart';
import 'package:ob_admin_panel/src/ui/widgets/devices_page_widgets/devices_table_content.dart';
import 'package:ob_admin_panel/src/ui/widgets/devices_page_widgets/devices_table_header.dart';

class DevicesTable extends StatefulWidget {
  const DevicesTable({
    @required this.columns,
    @required this.isMobileView,
  });

  final List<Field> columns;
  final bool isMobileView;

  @override
  _DevicesTableState createState() => _DevicesTableState();
}

class _DevicesTableState extends State<DevicesTable> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 1780.0,
          child: Column(
            children: [
              DevicesTableHeader(
                columns: widget.columns,
                isMobileView: widget.isMobileView,
              ),
              const SizedBox(
                height: 15.0,
              ),
              DevicesTableContent(
                columns: widget.columns,
                isMobileView: widget.isMobileView,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
