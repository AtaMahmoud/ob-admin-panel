import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/helpers/size_calcs.dart';
import 'package:ob_admin_panel/src/models/seapod.dart';
import 'package:ob_admin_panel/src/models/table_column.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/pages/seapod_details/seapod_datails_page.dart';
import 'package:ob_admin_panel/src/ui/widgets/desktop_main_view.dart';
import 'package:ob_admin_panel/src/ui/widgets/map_tab.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';
import 'package:ob_admin_panel/src/ui/widgets/table_header.dart';
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
  List<TableColumn> columns = [
    TableColumn(columnName: ConstantTexts.seapod),
    TableColumn(columnName: ConstantTexts.owner),
    TableColumn(columnName: ConstantTexts.type),
    TableColumn(columnName: ConstantTexts.location),
    TableColumn(columnName: ConstantTexts.status),
    TableColumn(columnName: ConstantTexts.accessLevel),
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
                        TableHeader(
                          children: tableFieldsList(),
                        ),
                        if (!_isLoading)
                          SeapodsTableContent(
                            columns: columns,
                          ),
                        if (_isLoading)
                          Container(
                            height: 500,
                          ),
                        const AddSeapodButton()
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
                margin: EdgeInsets.only(right: tabViewWidth * 0.1),
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

  List<Widget> tableFieldsList() {
    final selectedColumns =
        columns.where((element) => element.isChecked).toList();
    final List<Widget> widgets = [];
    for (final element in selectedColumns) {
      widgets.add(TableHeaderField(text: element.columnName));
    }
    return widgets;
  }
}

class SeapodsTableContent extends StatefulWidget {
  const SeapodsTableContent({
    Key key,
    @required this.columns,
  }) : super(key: key);

  final List<TableColumn> columns;

  @override
  _SeapodsTableContentState createState() => _SeapodsTableContentState();
}

class _SeapodsTableContentState extends State<SeapodsTableContent> {
  SeaPodsProvider seaPodsProvider;

  @override
  Widget build(BuildContext context) {
    seaPodsProvider = Provider.of<SeaPodsProvider>(context, listen: false);
    final seapods = seaPodsProvider.allSeaPods.data;
    final customDivider = Container(
      height: 1,
      color: const Color(
        ColorConstants.tableViewDividerColor,
      ),
    );
    final itemCount = seapods.length;
    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              seaPodsProvider.updateSelectedSeapod(seapods[index]);
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      SeapodDetailsPage(),
                  transitionDuration: const Duration(),
                  settings:
                      const RouteSettings(name: SeapodDetailsPage.routeName),
                ),
              );
            },
            child: Container(
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
                  if (index != itemCount - 1) customDivider,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  TextStyle tableContentTextStyle() {
    return const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: Color(ColorConstants.tableViewTextColor),
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
              ConstantTexts.latitude + seaPodLocation.latitude.toString(),
              textAlign: TextAlign.start,
              style: tableContentTextStyle(),
            ),
            Text(
              ConstantTexts.logitude + seaPodLocation.longitude.toString(),
              textAlign: TextAlign.start,
              style: tableContentTextStyle(),
            ),
          ],
        ),
      ),
    );
  }

  Widget tableFieldContent(
    String content,
  ) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 5,
          right: 10,
          bottom: 5,
        ),
        child: Text(
          content,
          textAlign: TextAlign.start,
          style: tableContentTextStyle(),
        ),
      ),
    );
  }

  List<Widget> _seapodDetails(SeaPod seaPod) {
    return [
      if (widget.columns[0].isChecked)
        tableFieldContent(
          seaPod.seaPodName,
        ),
      if (widget.columns[1].isChecked)
        tableFieldContent(
          seaPod.ownersNames.join(', '),
        ),
      if (widget.columns[2].isChecked)
        tableFieldContent(
          seaPod.seaPodType,
        ),
      if (widget.columns[3].isChecked)
        buildLocationField(
          seaPod.location,
        ),
      if (widget.columns[4].isChecked)
        tableFieldContent(
          seaPod.seaPodStatus,
        ),
      if (widget.columns[5].isChecked)
        tableFieldContent(
          seaPod.accessLevel,
        ),
    ];
  }
}

class AddSeapodButton extends StatelessWidget {
  const AddSeapodButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class FilterBubble extends StatefulWidget {
  const FilterBubble({
    Key key,
    @required this.columns,
    @required this.applyFilter,
  }) : super(key: key);

  final List<TableColumn> columns;
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
