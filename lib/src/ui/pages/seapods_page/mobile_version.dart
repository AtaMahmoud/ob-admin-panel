import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/helpers/api_response.dart';
import 'package:ob_admin_panel/src/models/seapod.dart';
import 'package:ob_admin_panel/src/models/field.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/widgets/admin_panel_header.dart';
import 'package:ob_admin_panel/src/ui/widgets/filter_bubble.dart';
import 'package:ob_admin_panel/src/ui/widgets/map_tab.dart';
import 'package:ob_admin_panel/src/ui/widgets/mobile_left_navigation_drawer.dart';
import 'package:ob_admin_panel/src/ui/widgets/tab_title.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class MobileSeapodsPage extends StatefulWidget {
  final int seapodsViewIndex;
  final VoidCallback onMapTap;
  final VoidCallback onListTap;

  const MobileSeapodsPage({
    @required this.seapodsViewIndex,
    @required this.onMapTap,
    @required this.onListTap,
  });
  @override
  _MobileSeapodsPageState createState() => _MobileSeapodsPageState();
}

class _MobileSeapodsPageState extends State<MobileSeapodsPage>
    with SingleTickerProviderStateMixin {
  var _isInit = true;
  var _showFilterbubble = false;
  SeaPodsProvider seaPodsProvider;
  List<Field> fields = [
    Field(fieldName: ConstantTexts.seapod),
    Field(fieldName: ConstantTexts.owner),
    Field(fieldName: ConstantTexts.type),
    Field(fieldName: ConstantTexts.location),
    Field(fieldName: ConstantTexts.status),
    Field(fieldName: ConstantTexts.accessLevel),
  ];

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      seaPodsProvider = Provider.of<SeaPodsProvider>(
        context,
        listen: false,
      );
      await seaPodsProvider.getAllSeapods();
      setState(() {});
      _isInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    const _textStyle = TextStyle(
      color: Color(0xFF043D8D),
      fontSize: 18,
      fontWeight: FontWeight.w700,
    );
    final allSeapods = seaPodsProvider.allSeaPods;
    return Scaffold(
      drawer: const MobileLeftNavigationMenu(
        tappedMenuIndex: Constants.homeIndex,
      ),
      drawerScrimColor: const Color(ColorConstants.drawerScrimColor),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                MobileHeader(
                  showFilterIcon: widget.seapodsViewIndex == 0,
                  onTappingFilterIcon: () {
                    setState(() {
                      _showFilterbubble = !_showFilterbubble;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TabTitle(
                        ConstantTexts.seapods,
                      ),
                      SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: widget.onMapTap,
                              child: const Text(
                                ConstantTexts.map,
                                style: _textStyle,
                              ),
                            ),
                            const Text(
                              '|',
                              style: _textStyle,
                            ),
                            GestureDetector(
                              onTap: widget.onListTap,
                              child: const Text(
                                ConstantTexts.list,
                                style: _textStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (allSeapods.status == Status.loading ||
                    allSeapods.data == null)
                  const SizedBox(
                    height: 300,
                    child: SpinKitFadingCircle(
                      color: Color(ColorConstants.mainColor),
                    ),
                  ),
                if (allSeapods.status == Status.completed &&
                    allSeapods.data != null)
                  Expanded(
                    child: IndexedStack(
                      index: widget.seapodsViewIndex,
                      children: [
                        SeapodsView(
                          allSeapods: allSeapods.data,
                        ),
                        MapTab(
                          seapods: allSeapods.data,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            if (_showFilterbubble)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 20.0),
                child: FilterBubble(
                  fields: fields,
                  applyFilter: () {
                    setState(() {});
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SeapodsView extends StatelessWidget {
  const SeapodsView({
    Key key,
    @required this.allSeapods,
  }) : super(key: key);

  final List<SeaPod> allSeapods;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allSeapods.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.only(top: 10.0),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: index % 2 == 0
                ? Colors.white
                : const Color(ColorConstants.seapodsCardBackground),
            border: Border.all(
              color: const Color(ColorConstants.tableViewTextColor),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SeapodInformationRow(
                titleText: ConstantTexts.name,
                infoText: allSeapods[index].seaPodName,
              ),
              SeapodInformationRow(
                titleText: ConstantTexts.owner,
                infoText: allSeapods[index].ownersNames.join(', '),
              ),
              SeapodInformationRow(
                titleText: ConstantTexts.type,
                infoText: allSeapods[index].seaPodType,
              ),
              SeapodInformationRow(
                titleText: ConstantTexts.location,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SeapodCardText(
                      text: allSeapods[index].location.locationName,
                    ),
                    SeapodCardText(
                      text: ConstantTexts.latitude +
                          allSeapods[index]
                              .location
                              .latitude
                              .toStringAsFixed(4),
                    ),
                    SeapodCardText(
                      text: ConstantTexts.longitude +
                          allSeapods[index]
                              .location
                              .longitude
                              .toStringAsFixed(4),
                    ),
                  ],
                ),
              ),
              SeapodInformationRow(
                titleText: ConstantTexts.status,
                infoText: allSeapods[index].seaPodStatus,
              ),
              SeapodInformationRow(
                titleText: ConstantTexts.accessLevel,
                infoText: allSeapods[index].accessLevel,
              ),
            ],
          ),
        );
      },
    );
  }
}

class SeapodInformationRow extends StatelessWidget {
  const SeapodInformationRow(
      {@required this.titleText, this.infoText, this.child});

  final String titleText;
  final String infoText;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: mediaQuery.width * 0.35,
            child: SeapodCardText(text: titleText),
          ),
          child ??
              Expanded(
                child: SeapodCardText(
                  text: infoText,
                ),
              ),
        ],
      ),
    );
  }
}

class SeapodCardText extends StatelessWidget {
  const SeapodCardText({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(
          ColorConstants.tableViewTextColor,
        ),
      ),
    );
  }
}
