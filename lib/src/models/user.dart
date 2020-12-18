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

  User(
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
  );
  User.fromJson(Map<String, dynamic> json) {
    isDisabled = json['isDisabled'];
    lighting = Lighting.fromJson(json['lighting']);
    accessPeriod = json['accessPeriod'];
    checkInDate = json['checkInDate'];
    id = json['_id'];
    userName = json['userName'];
    profilePicUrl = json['profilePicUrl'];
    notificationToken = json['notificationToken'];
    type = json['type'];
    permissionSet = PermissionSet.fromJson(json['permissionSet']);
     }
}

class Lighting {
  bool status;
  num intensity;
  List lightScenes;
  String id;
  String selectedScene;

  Lighting(
    this.status,
    this.intensity,
    this.lightScenes,
    this.id,
    this.selectedScene,
  );

  Lighting.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    intensity = json['intensity'];
    id = json['_id'];
    selectedScene = json['selectedScene'];
  }
}
