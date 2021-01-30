import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/helpers/size_calcs.dart';
import 'package:ob_admin_panel/src/models/seapod.dart';
import 'package:ob_admin_panel/src/models/table_column.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/widgets/desktop_main_view.dart';
import 'package:ob_admin_panel/src/ui/widgets/map_tab.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';
import 'package:provider/provider.dart';
import 'package:speech_bubble/speech_bubble.dart';

class DesktopSeapodsPage extends StatefulWidget {
  final int seapodsViewIndex;
  final VoidCallback onMapTap;
  final VoidCallback onListTap;

  const DesktopSeapodsPage({
    @required this.seapodsViewIndex,
    @required this.onMapTap,
    @required this.onListTap,
  });

  @override
  _DesktopSeapodsPageState createState() => _DesktopSeapodsPageState();
}

class _DesktopSeapodsPageState extends State<DesktopSeapodsPage> {
  var _isInit = true;
  var _isLoading = false;
  SeaPodsProvider seaPodsProvider;
  bool showFilterMenu = false;
  List<SeapodTableColumn> columns = [
    SeapodTableColumn(columnName: ConstantTexts.seapod),
    SeapodTableColumn(columnName: ConstantTexts.owner),
    SeapodTableColumn(columnName: ConstantTexts.type),
    SeapodTableColumn(columnName: ConstantTexts.location),
    SeapodTableColumn(columnName: ConstantTexts.status),
    SeapodTableColumn(columnName: ConstantTexts.accessLevel),
  ];

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      seaPodsProvider = Provider.of<SeaPodsProvider>(
        context,
        listen: false,
      );
      await seaPodsProvider.getAllSeapods();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final allSeapods = seaPodsProvider.allSeaPods.data;
    final sizeCalcs = SizeCalcs(context: context);
    final tabViewWidth = sizeCalcs.calculateTabViewWidth();
    return DesktopMainView(
      viewIndex: Constants.homeIndex,
      view: Container(
        color: Color(
          widget.seapodsViewIndex == 1
              ? ColorConstants.mabBackground
              : ColorConstants.tabBackground,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 30,
                top: 25,
              ),
              height: 75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TabTitle(
                    ConstantTexts.seapods,
                  ),
                  SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        buildSwitcher(
                          widget.onMapTap,
                          ConstantTexts.map,
                          BoxDecoration(
                            color: Color(
                              widget.seapodsViewIndex == 1
                                  ? ColorConstants.switcherColor
                                  : ColorConstants.loginRegisterTextColor,
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            ),
                          ),
                        ),
                        Container(
                          width: 1,
                          color: Colors.white,
                        ),
                        buildSwitcher(
                          widget.onListTap,
                          ConstantTexts.list,
                          BoxDecoration(
                            color: Color(
                              widget.seapodsViewIndex == 0
                                  ? ColorConstants.switcherColor
                                  : ColorConstants.loginRegisterTextColor,
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (widget.seapodsViewIndex == 0)
              Container(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 30,
                  bottom: 30,
                ),
                margin: EdgeInsets.only(right: tabViewWidth * 0.15),
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
                              GestureDetector(
                                onTap: () => setState(
                                  () => showFilterMenu = !showFilterMenu,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    ImagePaths.tableFilterIcon,
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        buildTableHeader(),
                        if (!_isLoading) buildTableContent(allSeapods),
                        if (_isLoading)
                          Container(
                            height: 500,
                          ),
                        buildAddSeapodButton()
                      ],
                    ),
                    if (showFilterMenu)
                      FilterBubble(
                        columns: columns,
                        applyFilter: () {
                          setState(() {});
                        },
                      ),
                  ],
                ),
              ),
            if (!_isLoading && widget.seapodsViewIndex == 1)
              Container(
                margin: EdgeInsets.only(right: tabViewWidth * 0.15),
                height: 650,
                child: MapTab(
                  seapods: allSeapods,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildAddSeapodButton() {
    return DottedBorder(
      color: const Color(ColorConstants.addSeapodColor),
      dashPattern: const [8],
      borderType: BorderType.RRect,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        height: 54,
        child: const Center(
          child: Icon(
            CupertinoIcons.add,
            size: 40,
            color: Color(ColorConstants.addSeapodColor),
          ),
        ),
      ),
    );
  }

  GestureDetector buildSwitcher(
    void Function() onTap,
    String text,
    BoxDecoration decoration,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: decoration,
        width: 80,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDivider() {
    return Container(
      height: 1,
      color: const Color(
        ColorConstants.tableViewDividerColor,
      ),
    );
  }

  Widget buildTableContent(List<SeaPod> seapods) {
    final itemCount = seapods.length;
    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 10,
            ),
            child: Column(
              children: [
                Row(
                  children: _seapodDetails(
                    seaPodsProvider.allSeaPods.data[index],
                  ),
                ),
                if (index != itemCount - 1) buildDivider(),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _seapodDetails(SeaPod seaPod) {
    return [
      if (columns[0].isChecked)
        buildTableCell(
          seaPod.seaPodName,
        ),
      if (columns[1].isChecked)
        buildTableCell(
          seaPod.ownersNames.join(', '),
        ),
      if (columns[2].isChecked)
        buildTableCell(
          seaPod.seaPodType,
        ),
      if (columns[3].isChecked)
        buildLocationField(
          seaPod.location,
        ),
      if (columns[4].isChecked)
        buildTableCell(
          seaPod.seaPodStatus,
        ),
      if (columns[5].isChecked)
        buildTableCell(
          seaPod.accessLevel,
        ),
    ];
  }

  Widget buildTableHeader() {
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
        children: _tableFieldsList(),
      ),
    );
  }

  List<Widget> _tableFieldsList() {
    final selectedColumns =
        columns.where((element) => element.isChecked).toList();
    final List<Widget> widgets = [];
    for (final element in selectedColumns) {
      widgets.add(buildTableField(element.columnName));
    }
    return widgets;
  }

  Widget buildTableField(
    String cellName,
  ) {
    return Expanded(
      child: Text(
        cellName.toUpperCase(),
        textAlign: TextAlign.start,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildTableCell(
    String cellName,
  ) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 5,
          right: 10,
          bottom: 5,
        ),
        child: Text(
          cellName,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(
              ColorConstants.tableViewTextColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLocationField(
    Location seaPodLocation,
  ) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 5,
          right: 20,
          bottom: 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              seaPodLocation.locationName,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(ColorConstants.tableViewTextColor),
              ),
            ),
            Text(
              ConstantTexts.latitude +
                  seaPodLocation.latitude.toStringAsFixed(4),
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w500,
                color: Color(ColorConstants.tableViewTextColor),
              ),
            ),
            Text(
              ConstantTexts.logitude +
                  seaPodLocation.longitude.toStringAsFixed(4),
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w500,
                color: Color(ColorConstants.tableViewTextColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterBubble extends StatefulWidget {
  const FilterBubble({
    Key key,
    @required this.columns,
    @required this.applyFilter,
  }) : super(key: key);

  final List<SeapodTableColumn> columns;
  final Function applyFilter;

  @override
  _FilterBubbleState createState() => _FilterBubbleState();
}

class _FilterBubbleState extends State<FilterBubble> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: const EdgeInsets.only(top: 42),
        child: SpeechBubble(
          nipHeight: 15.0,
          borderRadius: 8.0,
          nipLocation: NipLocation.TOP_RIGHT,
          offset: const Offset(-25.0, 0.0),
          width: 222,
          height: 285,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          color: const Color(ColorConstants.loginRegisterTextColor)
              .withOpacity(0.85),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                ConstantTexts.showColumns,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
              ...[
                for (var column in widget.columns) ...[
                  Row(
                    children: [
                      Checkbox(
                        value: column.isChecked,
                        hoverColor: Colors.white,
                        fillColor: MaterialStateProperty.all(Colors.white),
                        checkColor:
                            const Color(ColorConstants.loginRegisterTextColor),
                        activeColor: Colors.white,
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        onChanged: (value) {
                          setState(() {
                            column.isChecked = value;
                            widget.applyFilter();
                          });
                        },
                      ),
                      Text(
                        column.columnName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13.0,
                        ),
                      )
                    ],
                  )
                ]
              ]
            ],
          ),
        ),
      ),
    );
  }
}
