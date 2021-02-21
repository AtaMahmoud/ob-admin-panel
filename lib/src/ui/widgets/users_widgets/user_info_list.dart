import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/ui/widgets/users_widgets/information_row.dart';

class UserInfoList extends StatefulWidget {
  const UserInfoList({Key key, this.onDetailsButtonTapped}) : super(key: key);

  final VoidCallback onDetailsButtonTapped;

  @override
  _UserInfoListState createState() => _UserInfoListState();
}

class _UserInfoListState extends State<UserInfoList> {
  @override
  Widget build(BuildContext context) {
    const divider = Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Divider(
        color: Colors.white,
      ),
    );
    return Column(
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
              GestureDetector(
                onTap: widget.onDetailsButtonTapped,
                child: Container(
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
    );
  }
}
