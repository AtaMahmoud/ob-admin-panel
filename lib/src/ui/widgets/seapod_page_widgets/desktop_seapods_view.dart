import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/constants/constant_texts.dart';
import 'package:ob_admin_panel/src/helpers/size_calcs.dart';
import 'package:ob_admin_panel/src/models/field.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/widgets/add_new_element.dart';
import 'package:ob_admin_panel/src/ui/widgets/filter_icon.dart';
import 'package:ob_admin_panel/src/ui/widgets/seapod_page_widgets/add_new_seapod_popover.dart';
import 'package:ob_admin_panel/src/ui/widgets/seapod_page_widgets/seapods_table_content.dart';
import 'package:ob_admin_panel/src/ui/widgets/table_header.dart';
import 'package:ob_admin_panel/src/ui/widgets/filter_bubble.dart';
import 'package:provider/provider.dart';

class DesktopSeapodsView extends StatefulWidget {
  @override
  _DesktopSeapodsViewState createState() => _DesktopSeapodsViewState();
}

class _DesktopSeapodsViewState extends State<DesktopSeapodsView> {
  bool showFilterMenu = false;
  List<Field> columns = [
    Field(fieldName: ConstantTexts.seapod),
    Field(fieldName: ConstantTexts.owner),
    Field(fieldName: ConstantTexts.type),
    Field(fieldName: ConstantTexts.location),
    Field(fieldName: ConstantTexts.status),
    Field(fieldName: ConstantTexts.accessLevel),
  ];
  @override
  Widget build(BuildContext context) {
    final allSeapods = Provider.of<SeaPodsProvider>(context).allSeaPods.data;
    final sizeCalcs = SizeCalcs(context: context);
    final tabViewWidth = sizeCalcs.calculateTabViewWidth();
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 30,
        bottom: 30,
      ),
      margin: EdgeInsets.only(right: tabViewWidth * 0.1),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                margin: const EdgeInsets.only(right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilterIcon(
                      onTap: () => setState(
                        () => showFilterMenu = !showFilterMenu,
                      ),
                    )
                  ],
                ),
              ),
              TableHeader(
                children: tableFieldsList(),
              ),
              if (allSeapods != null)
                SeapodsTableContent(
                  columns: columns,
                ),
              if (allSeapods == null)
                Container(
                  height: 500,
                ),
              //Add new seapod
              AddNewElement(
                hintText: ConstantTexts.addNewSeapod,
                onTap: () {
                  showDialog(
                    barrierColor: const Color(ColorConstants.drawerScrimColor),
                    context: context,
                    builder: (context) {
                      return const AddNewSeapodPopover();
                    },
                  );
                },
              )
            ],
          ),
          if (showFilterMenu)
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 45.0,
                ),
                child: FilterBubble(
                  fields: columns,
                  applyFilter: () {
                    setState(() {});
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> tableFieldsList() {
    final selectedColumns =
        columns.where((element) => element.isChecked).toList();
    final List<Widget> widgets = [];
    for (final element in selectedColumns) {
      widgets.add(TableHeaderField(text: element.fieldName));
    }
    return widgets;
  }
}
