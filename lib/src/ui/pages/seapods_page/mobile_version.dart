import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/helpers/api_response.dart';
import 'package:ob_admin_panel/src/models/seapod.dart';
import 'package:ob_admin_panel/src/providers/seapods_provider.dart';
import 'package:ob_admin_panel/src/ui/widgets/admin_panel_header.dart';
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
  SeaPodsProvider seaPodsProvider;
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
        child: Column(
          children: [
            const MobileHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
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
            if (allSeapods.status == Status.loading || allSeapods.data == null)
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
                    SeapodsView(allSeapods: allSeapods.data),
                    MapTab(
                      seapods: allSeapods.data,
                    ),
                  ],
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
  Widget buildSeapodCardText(
    String text,
  ) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(
          ColorConstants.tableViewTextColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: allSeapods.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.all(15.0),
          height: 230,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: _mediaQuery.width * 0.35,
                    child: buildSeapodCardText(ConstantTexts.name),
                  ),
                  Expanded(
                    child: buildSeapodCardText(
                      allSeapods[index].seaPodName,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: _mediaQuery.width * 0.35,
                    child: buildSeapodCardText(ConstantTexts.owner),
                  ),
                  Expanded(
                    child: buildSeapodCardText(
                      allSeapods[index].ownersNames.join(', '),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: _mediaQuery.width * 0.35,
                    child: buildSeapodCardText(ConstantTexts.type),
                  ),
                  buildSeapodCardText(allSeapods[index].seaPodType),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: _mediaQuery.width * 0.35,
                    child: buildSeapodCardText(ConstantTexts.location),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSeapodCardText(
                          allSeapods[index].location.locationName),
                      buildSeapodCardText(ConstantTexts.latitude +
                          allSeapods[index]
                              .location
                              .latitude
                              .toStringAsFixed(4)),
                      buildSeapodCardText(ConstantTexts.logitude +
                          allSeapods[index]
                              .location
                              .longitude
                              .toStringAsFixed(4)),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: _mediaQuery.width * 0.35,
                    child: buildSeapodCardText(ConstantTexts.status),
                  ),
                  buildSeapodCardText(allSeapods[index].seaPodStatus),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: _mediaQuery.width * 0.35,
                    child: buildSeapodCardText(ConstantTexts.accessLevel),
                  ),
                  buildSeapodCardText(allSeapods[index].accessLevel),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
