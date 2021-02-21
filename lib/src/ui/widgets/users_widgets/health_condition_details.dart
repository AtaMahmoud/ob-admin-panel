import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/ui/widgets/users_widgets/information_row.dart';

class HealthConditionDetails extends StatefulWidget {
  @override
  _HealthConditionDetailsState createState() => _HealthConditionDetailsState();
}

class _HealthConditionDetailsState extends State<HealthConditionDetails> {
  @override
  Widget build(BuildContext context) {
    const divider = Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Divider(
        color: Colors.white,
      ),
    );
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: const [
            InformationRow(
              title: ConstantTexts.allergies,
              info: 'Nuts, Tuna, Gluten, Eggs',
            ),
            divider,
            InformationRow(
              title: ConstantTexts.bloodType,
              info: 'B Positive',
            ),
            divider,
            InformationRow(
              title: ConstantTexts.healthCondition,
              info: 'Asthma',
            ),
            divider,
            InformationRow(
              title: ConstantTexts.swiimmingAbility,
              info: 'Yes',
            ),
            divider,
            InformationRow(
              title: ConstantTexts.bodyType,
              info: 'Athletic',
            ),
            divider,
            InformationRow(
              title: ConstantTexts.age,
              info: '36',
            ),
            divider,
            InformationRow(
              title: ConstantTexts.weight,
              info: '85',
            ),
            divider,
            InformationRow(
              title: ConstantTexts.hair,
              info: 'Black',
            ),
          ],
        ),
      ),
    );
  }
}
