import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/models/seapod.dart';
import 'package:ob_admin_panel/src/models/table_column.dart';
import 'package:ob_admin_panel/src/ui/widgets/user_info_bubble.dart';
import 'package:responsive_builder/responsive_builder.dart';

class UsersTableContent extends StatefulWidget {
  const UsersTableContent({
    Key key,
    @required this.columns,
  }) : super(key: key);

  final List<TableColumn> columns;

  @override
  _UsersTableContentState createState() => _UsersTableContentState();
}

class _UsersTableContentState extends State<UsersTableContent> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final padding = MediaQuery.of(context).padding;
    return ResponsiveBuilder(
      builder: (context, sizingInfo) {
        return sizingInfo.deviceScreenType == DeviceScreenType.desktop
            ? SizedBox(
                height: 650,
                child: buildListView(),
              )
            : SizedBox(
                height: height -
                    kToolbarHeight -
                    padding.top -
                    padding.bottom -
                    206,
                child: buildListView());
      },
    );
  }

  ListView buildListView() {
    final customDivider = Container(
      height: 1,
      color: const Color(
        ColorConstants.tableViewDividerColor,
      ),
    );
    const itemCount = 20;
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 10,
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    children: userDetails(
                      showUserName: true,
                    ),
                  ),
                  if (isExpanded)
                    Row(
                      children: userDetails(showUserName: false),
                    ),
                  if (index != itemCount - 1) customDivider,
                  if (index == itemCount - 1)
                    const SizedBox(
                      height: 400,
                    ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Icon(
                      isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      size: 40,
                      color: const Color(
                        ColorConstants.tableViewTextColor,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  TextStyle tableContentTextStyle({
    Color color,
  }) {
    return TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: color ?? const Color(ColorConstants.textColor),
    );
  }

  Widget tableFieldContent(
    String content, {
    Color color,
  }) {
    return Expanded(
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 5,
            right: 10,
            bottom: 5,
          ),
          child: Text(
            content,
            textAlign: TextAlign.start,
            style: tableContentTextStyle(
              color: color,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLocationField(Location location) {
    const sizedBox = SizedBox(
      height: 15,
    );
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 15,
          right: 20,
          bottom: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              location.locationName,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(ColorConstants.textColor),
              ),
            ),
            sizedBox,
            Text(
              '${ConstantTexts.latitude}${location.latitude}',
              textAlign: TextAlign.start,
              style: tableContentTextStyle(),
            ),
            sizedBox,
            Text(
              '${ConstantTexts.longitude}${location.longitude}',
              textAlign: TextAlign.start,
              style: tableContentTextStyle(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSeapodField(
    SeaPod seapod,
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
              seapod.seaPodName,
              textAlign: TextAlign.start,
              style: tableContentTextStyle(
                color: const Color(ColorConstants.mainColor),
              ),
            ),
            Text(
              seapod.seaPodType,
              textAlign: TextAlign.start,
              style: tableContentTextStyle(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> userDetails({
    bool showUserName,
  }) {
    return [
      if (widget.columns[0].isChecked)
        UserNameField(
          userName: showUserName ? 'John Doe' : '',
        ),
      if (widget.columns[1].isChecked)
        buildSeapodField(
          SeaPod(
            seaPodName: 'Black Pearl',
            seaPodType: 'Private',
          ),
        ),
      if (widget.columns[2].isChecked)
        tableFieldContent(
          '12/08/2019',
          color: const Color(ColorConstants.dateColor),
        ),
      if (widget.columns[3].isChecked)
        tableFieldContent(
          'Member',
        ),
      if (widget.columns[4].isChecked)
        tableFieldContent(
          'Full',
        ),
      if (widget.columns[5].isChecked)
        buildLocationField(
          Location(
            locationName: 'Panama',
            latitude: 2.24548755,
            longitude: 4.0215454,
          ),
        ),
    ];
  }
}

class UserNameField extends StatefulWidget {
  const UserNameField({
    @required this.userName,
  });
  final String userName;

  @override
  _UserNameFieldState createState() => _UserNameFieldState();
}

class _UserNameFieldState extends State<UserNameField> {
  final FocusNode _focusNode = FocusNode();

  OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context).insert(_overlayEntry);
      } else {
        _overlayEntry.remove();
      }
    });
    super.initState();
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: 410,
        height: 440,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 20.0),
          child: UserInformationBubble(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CompositedTransformTarget(
        link: _layerLink,
        child: GestureDetector(
          onTap: () {
            if (_focusNode.hasFocus) {
              _focusNode.unfocus();
            } else {
              FocusScope.of(context).requestFocus(_focusNode);
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: 5,
              right: 10,
              bottom: 5,
            ),
            child: Text(
              widget.userName,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(ColorConstants.mainColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
