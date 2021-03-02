import 'package:flutter/material.dart';

class TitleInfoWidget extends StatelessWidget {
  const TitleInfoWidget({Key key, @required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class InformationRow extends StatelessWidget {
  const InformationRow({
    Key key,
    @required this.title,
    this.info,
    this.child,
  }) : super(key: key);

  final String title;
  final String info;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleInfoWidget(text: title),
          Expanded(
            child: child ?? InfoWidget(info: info),
          ),
        ],
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    Key key,
    @required this.info,
  }) : super(key: key);

  final String info;

  @override
  Widget build(BuildContext context) {
    return Text(
      info,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14.0,
      ),
    );
  }
}