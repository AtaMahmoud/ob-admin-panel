import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constant_texts.dart';
import 'package:ob_admin_panel/src/models/field.dart';

abstract class FieldsInitializer {
  static List<Field> seapodPageFields() {
    return [
      Field(
        fieldName: ConstantTexts.seapod,
        isFixed: true,
      ),
      Field(fieldName: ConstantTexts.owner),
      Field(fieldName: ConstantTexts.type),
      Field(fieldName: ConstantTexts.location),
      Field(fieldName: ConstantTexts.status),
      Field(fieldName: ConstantTexts.accessLevel),
    ];
  }

  static List<Field> usersPageFields() {
    return [
      Field(fieldName: ConstantTexts.name),
      Field(fieldName: ConstantTexts.seapod.toUpperCase()),
      Field(fieldName: ConstantTexts.memberSince),
      Field(fieldName: ConstantTexts.type),
      Field(
        fieldName: ConstantTexts.access.toUpperCase(),
      ),
      Field(fieldName: ConstantTexts.location),
    ];
  }

  static List<Field> devicesPageFields({
    bool isMobileView = false,
  }) {
    return [
      Field(fieldName: ConstantTexts.category, isFixed: true),
      Field(
        fieldName: ConstantTexts.device,
        textAlign: isMobileView ? TextAlign.start : TextAlign.center,
      ),
      Field(
        fieldName: ConstantTexts.element,
        textAlign: TextAlign.center,
        isFixed: true,
      ),
      Field(
        fieldName: ConstantTexts.product,
      ),
      Field(
        fieldName: ConstantTexts.lifeSpan,
        textAlign: TextAlign.center,
      ),
      Field(
        fieldName: ConstantTexts.maintenance,
        textAlign: TextAlign.center,
      ),
      Field(
        fieldName: ConstantTexts.usageStartDate,
        textAlign: TextAlign.center,
      ),
      Field(
        fieldName: ConstantTexts.maintenanceDate,
        textAlign: TextAlign.center,
      ),
      Field(
        fieldName: ConstantTexts.changeDate,
        textAlign: TextAlign.center,
      ),
      Field(
        fieldName: ConstantTexts.location,
        textAlign: TextAlign.center,
      ),
      Field(
        fieldName: ConstantTexts.cost,
        textAlign: TextAlign.center,
      ),
      Field(
        fieldName: ConstantTexts.status,
        textAlign: TextAlign.center,
      ),
      Field(
        fieldName: ConstantTexts.importance,
        textAlign: TextAlign.center,
      ),
    ];
  }
}
