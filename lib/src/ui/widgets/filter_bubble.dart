import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/color_constants.dart';
import 'package:ob_admin_panel/src/constants/constant_texts.dart';
import 'package:ob_admin_panel/src/models/field.dart';
import 'package:speech_bubble/speech_bubble.dart';

class FilterBubble extends StatefulWidget {
  const FilterBubble({
    Key key,
    @required this.fields,
    this.applyFilter,
  }) : super(key: key);

  final List<Field> fields;
  final Function applyFilter;

  @override
  _FilterBubbleState createState() => _FilterBubbleState();
}

class _FilterBubbleState extends State<FilterBubble> {
  @override
  Widget build(BuildContext context) {
    return SpeechBubble(
      nipHeight: 15.0,
      borderRadius: 8.0,
      nipLocation: NipLocation.TOP_RIGHT,
      offset: const Offset(-25.0, 0.0),
      width: 222,
      padding: const EdgeInsets.all(
        15.0,
      ),
      color: const Color(ColorConstants.loginRegisterTextColor).withOpacity(
        0.85,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              ConstantTexts.showColumns,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
            ),
          ),
          ...[
            for (var field in widget.fields) ...[
              SizedBox(
                height: 35.0,
                child: Row(
                  children: [
                    Checkbox(
                      value: field.isChecked,
                      hoverColor: Colors.white,
                      fillColor: MaterialStateProperty.all(Colors.white),
                      checkColor: field.isFixed
                          ? const Color(ColorConstants.textColor)
                          : const Color(ColorConstants.loginRegisterTextColor),
                      activeColor: Colors.white,
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      onChanged: field.isFixed
                          ? null
                          : (value) {
                              setState(() {
                                field.isChecked = value;
                                widget.applyFilter();
                              });
                            },
                    ),
                    Text(
                      field.fieldName,
                      style: TextStyle(
                        color: field.isFixed
                            ? const Color(ColorConstants.textColor)
                            : Colors.white,
                        fontSize: 13.0,
                      ),
                    )
                  ],
                ),
              )
            ]
          ]
        ],
      ),
    );
  }
}
