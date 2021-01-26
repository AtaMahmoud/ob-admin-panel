import 'package:ob_admin_panel/src/models/permission_set.dart';

class User {
  bool isDisabled;
  Lighting lighting;
  num accessPeriod;
  num checkInDate;
  String id;
  String userName;
  String profilePicUrl;
  String notificationToken;
  String type;
  PermissionSet permissionSet;

  User({
    this.isDisabled,
    this.lighting,
    this.accessPeriod,
    this.checkInDate,
    this.id,
    this.userName,
    this.profilePicUrl,
    this.notificationToken,
    this.type,
    this.permissionSet,
  });
  User.fromJson(Map<String, dynamic> json) {
    isDisabled = json['isDisabled'] as bool;
    lighting = Lighting.fromJson(json['lighting'] as Map<String, dynamic>);
    accessPeriod = json['accessPeriod'] as num;
    checkInDate = json['checkInDate'] as num;
    id = json['_id'] as String;
    userName = json['userName'] as String;
    profilePicUrl = json['profilePicUrl'] as String;
    notificationToken = json['notificationToken'] as String;
    type = json['type'] as String;
    permissionSet =
        PermissionSet.fromJson(json['permissionSet'] as Map<String, dynamic>);
  }
}

class Lighting {
  bool status;
  num intensity;
  List lightScenes;
  String id;
  String selectedScene;

  Lighting({
    this.status,
    this.intensity,
    this.lightScenes,
    this.id,
    this.selectedScene,
  });

  Lighting.fromJson(Map<String, dynamic> json) {
    status = json['status'] as bool;
    intensity = json['intensity'] as num;
    id = json['_id'] as String;
    selectedScene = json['selectedScene'] as String;
  }
}
