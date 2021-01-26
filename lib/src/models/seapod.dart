import 'package:ob_admin_panel/src/models/light_scene.dart';
import 'package:ob_admin_panel/src/models/permission_set.dart';
import 'package:ob_admin_panel/src/models/seapod_owner.dart';
import 'package:ob_admin_panel/src/models/user.dart';

class SeaPod {
  List powerUtilities;
  List soundSystem;
  List<String> masterBedroomFloorFinishing;
  bool hasWeatherStation;
  bool hasCleanWaterLevelIndicator;
  List<PermissionSet> permissionSets;
  List<LightScene> lightScenes;
  num seaPodOrientation;
  List accessRequests;
  List accessInvitation;
  String id;
  String seaPodName;
  List<String> ownersNames;
  List<SeapodOwner> owners;
  String exteriorFinish;
  String exterioirColor;
  String sparFinish;
  String sparDesign;
  String deckEnclosure;
  String bedAndLivingRoomEnclousure;
  String power;
  String underWaterRoomFinishing;
  String underWaterWindows;
  String masterBedroomInteriorWallColor;
  String livingRoomloorFinishing;
  String livingRoomInteriorWallColor;
  String kitchenfloorFinishing;
  String kitchenInteriorWallColor;
  String entryStairs;
  String interiorBedroomWallColor;
  String deckFloorFinishMaterial;
  String seaPodStatus;
  String seaPodType;
  List<User> users;
  List<ActionHistory> actionsHistory;
  Location location;
  String vessleCode;
  String qrCodeImageUrl;
  String accessLevel;
  num v;

  SeaPod({
    this.powerUtilities,
    this.soundSystem,
    this.masterBedroomFloorFinishing,
    this.hasWeatherStation,
    this.hasCleanWaterLevelIndicator,
    this.permissionSets,
    this.lightScenes,
    this.seaPodOrientation,
    this.accessRequests,
    this.accessInvitation,
    this.id,
    this.seaPodName,
    this.ownersNames,
    this.owners,
    this.exteriorFinish,
    this.exterioirColor,
    this.sparFinish,
    this.sparDesign,
    this.deckEnclosure,
    this.bedAndLivingRoomEnclousure,
    this.power,
    this.underWaterRoomFinishing,
    this.underWaterWindows,
    this.masterBedroomInteriorWallColor,
    this.livingRoomloorFinishing,
    this.livingRoomInteriorWallColor,
    this.kitchenfloorFinishing,
    this.kitchenInteriorWallColor,
    this.entryStairs,
    this.interiorBedroomWallColor,
    this.deckFloorFinishMaterial,
    this.seaPodStatus,
    this.seaPodType,
    this.users,
    this.actionsHistory,
    this.location,
    this.vessleCode,
    this.qrCodeImageUrl,
    this.accessLevel,
    this.v,
  });

  SeaPod.fromJson(Map<String, dynamic> json) {
    /*  List powerUtilities;
  List soundSystem; */
    masterBedroomFloorFinishing = [];
    json['masterBedroomFloorFinishing'].forEach((e) {
      masterBedroomFloorFinishing.add(e as String);
    });
    hasWeatherStation = json['hasWeatherStation'] as bool;

    hasCleanWaterLevelIndicator = json['hasCleanWaterLevelIndicator'] as bool;
    permissionSets = [];
    json['permissionSets'].forEach((e) {
      permissionSets.add(PermissionSet.fromJson(e as Map<String, dynamic>));
    });
    lightScenes = [];
    json['lightScenes'].forEach((e) {
      lightScenes.add(LightScene.fromJson(e as Map<String, dynamic>));
    });
    seaPodOrientation = json['seaPodOrientation'] as num;
    /*  List accessRequests;
   List accessInvitation; */
    id = json['_id'] as String;

    seaPodName = json['SeaPodName'] as String;
    exteriorFinish = json['exteriorFinish'] as String;
    exterioirColor = json['exterioirColor'] as String;

    sparFinish = json['sparFinish'] as String;
    sparDesign = json['sparDesign'] as String;
    deckEnclosure = json['deckEnclosure'] as String;
    bedAndLivingRoomEnclousure = json['bedAndLivingRoomEnclousure'] as String;
    power = json['power'] as String;
    underWaterRoomFinishing = json['underWaterRoomFinishing'] as String;
    underWaterWindows = json['underWaterWindows'] as String;
    masterBedroomInteriorWallColor =
        json['masterBedroomInteriorWallColor'] as String;
    livingRoomloorFinishing = json['livingRoomloorFinishing'] as String;
    livingRoomInteriorWallColor = json['livingRoomInteriorWallColor'] as String;
    kitchenfloorFinishing = json['kitchenfloorFinishing'] as String;
    kitchenInteriorWallColor = json['kitchenInteriorWallColor'] as String;
    entryStairs = json['entryStairs'] as String;
    interiorBedroomWallColor = json['interiorBedroomWallColor'] as String;
    deckFloorFinishMaterial = json['deckFloorFinishMaterial'] as String;
    seaPodStatus = json['seaPodStatus'] as String;
    seaPodType = json['seaPodType'] as String ?? "";
    users = [];
    ownersNames = [];
    accessLevel = 'No Access';
    json['users'].forEach((user) {
      final userData = User.fromJson(user as Map<String, dynamic>);
      if (userData.type.toLowerCase() == 'owner') {
        ownersNames.add(userData.userName);
      }

      /*  if (userData.type.toLowerCase() == 'admin')
        accessLevel = userData.permissionSet; */

      users.add(userData);
    });

    actionsHistory = [];
    json['actionsHistory'].forEach((actionHistory) {
      actionsHistory
          .add(ActionHistory.fromJson(actionHistory as Map<String, dynamic>));
    });
    location = Location.fromJson(json['location'] as Map<String, dynamic>);
    vessleCode = json['vessleCode'] as String;
    qrCodeImageUrl = json['qrCodeImageUrl'] as String;
    v = json['__v'] as num;
  }
}

class ActionHistory {
  String id;
  String action;
  String actionResult;
  String userId;
  String userName;
  String userType;

  ActionHistory(
    this.id,
    this.action,
    this.actionResult,
    this.userId,
    this.userName,
    this.userType,
  );
  ActionHistory.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String;
    action = json['action'] as String;
    actionResult = json['actionResult'] as String;
    userId = json['userId'] as String;
    userName = json['userName'] as String;
    userType = json['userType'] as String;
  }
}

class Location {
  double latitude;
  double longitude;
  String locationName;

  Location(
    this.latitude,
    this.longitude,
    this.locationName,
  );

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'] as double;
    longitude = json['longitude'] as double;
    //TODO: add dynamic country name
    locationName = 'Panama';
  }
}
