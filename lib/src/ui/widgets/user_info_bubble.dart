import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:speech_bubble/speech_bubble.dart';

class UserInformationBubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const divider = Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Divider(
        color: Colors.white,
      ),
    );
    return SpeechBubble(
      nipLocation: NipLocation.TOP_LEFT,
      offset: const Offset(15, 0),
      nipHeight: 20.0,
      borderRadius: 7.0,
      color:
          const Color(ColorConstants.loginRegisterTextColor).withOpacity(0.8),
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: Column(
        children: [
          const InformationRow(
            title: ConstantTexts.gender,
            info: 'Male',
          ),
          divider,
          const InformationRow(
            title: ConstantTexts.nationality,
            info: 'American',
          ),
          divider,
          const InformationRow(title: ConstantTexts.languages, info: 'English'),
          divider,
          InformationRow(
            title: ConstantTexts.healthCondition,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  width: 95,
                  height: 30,
                  child: const Center(
                    child: Text(
                      ConstantTexts.details,
                      style: TextStyle(
                        color: Color(
                          ColorConstants.loginRegisterTextColor,
                        ),
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          divider,
          const InformationRow(
            title: ConstantTexts.email,
            info: 'johndoe87@gmail.com',
          ),
          divider,
          const InformationRow(
            title: ConstantTexts.phone,
            info: '574-8874-7454',
          ),
          divider,
          InformationRow(
            title: ConstantTexts.emmergencyContact,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                InfoWidget(info: 'Sally Doe'),
                SizedBox(
                  height: 5,
                ),
                InfoWidget(info: '457-8871-5411'),
                SizedBox(
                  height: 5,
                ),
                InfoWidget(info: 'sallydoe@gmail.com')
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key key, @required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
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
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
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
