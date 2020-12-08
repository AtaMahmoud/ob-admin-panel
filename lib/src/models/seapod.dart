
class SeaPod {
  List powerUtilities;
  List soundSystem;
  List<String> masterBedroomFloorFinishing;
  bool hasWeatherStation;
  bool hasCleanWaterLevelIndicator;
  List<String> permissionSets;
  List<String> lightScenes;
  num seaPodOrientation;
  List accessRequests;
  List accessInvitation;
  String id;
  String seaPodName;
  List<String> owners;
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

  SeaPod(
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
  );

  SeaPod.fromJson(Map<String, dynamic> json) {
    /*  List powerUtilities;
  List soundSystem; */
    masterBedroomFloorFinishing = List<String>();
    json['masterBedroomFloorFinishing'].forEach((e) {
      masterBedroomFloorFinishing.add(e);
    });
    hasWeatherStation = json['hasWeatherStation'];

    hasCleanWaterLevelIndicator = json['hasCleanWaterLevelIndicator'];
    permissionSets = List<String>();
    json['permissionSets'].forEach((e) {
      permissionSets.add(e);
    });
    lightScenes = List<String>();
    json['lightScenes'].forEach((e) {
      lightScenes.add(e);
    });
    seaPodOrientation = json['seaPodOrientation'];
    /*  List accessRequests;
  List accessInvitation; */
    id = json['_id'];

    seaPodName = json['SeaPodName'];
    exteriorFinish = json['exteriorFinish'];
    exterioirColor = json['exterioirColor'];

    sparFinish = json['sparFinish'];
    sparDesign = json['sparDesign'];
    deckEnclosure = json['deckEnclosure'];
    bedAndLivingRoomEnclousure = json['bedAndLivingRoomEnclousure'];
    power = json['power'];
    underWaterRoomFinishing = json['underWaterRoomFinishing'];
    underWaterWindows = json['underWaterWindows'];
    masterBedroomInteriorWallColor = json['masterBedroomInteriorWallColor'];
    livingRoomloorFinishing = json['livingRoomloorFinishing'];
    livingRoomInteriorWallColor = json['livingRoomInteriorWallColor'];
    kitchenfloorFinishing = json['kitchenfloorFinishing'];
    kitchenInteriorWallColor = json['kitchenInteriorWallColor'];
    entryStairs = json['entryStairs'];
    interiorBedroomWallColor = json['interiorBedroomWallColor'];
    deckFloorFinishMaterial = json['deckFloorFinishMaterial'];
    seaPodStatus = json['seaPodStatus'];
    seaPodType = json['seaPodType'] ?? "";
    users = List<User>();
    owners = List<String>();
    accessLevel = 'No Access';
    json['users'].forEach((user) {
      var userData = User.fromJson(user);
      if (userData.type.toLowerCase() == 'owner') owners.add(userData.userName);
      if (userData.type.toLowerCase() == 'admin')
        accessLevel = userData.permissionSet;

      users.add(userData);
    });

    actionsHistory = List<ActionHistory>();
    json['actionsHistory'].forEach((actionHistory) {
      actionsHistory.add(ActionHistory.fromJson(actionHistory));
    });
    location = Location.fromJson(json['location']);
    vessleCode = json['vessleCode'];
    qrCodeImageUrl = json['qrCodeImageUrl'];
    v = json['__v'];
  }
}

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
  String permissionSet;

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
    permissionSet = json['permissionSet'];
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
    id = json['_id'];
    action = json['action'];
    actionResult = json['actionResult'];
    userId = json['userId'];
    userName = json['userName'];
    userType = json['userType'];
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
    latitude = json['latitude'];
    longitude = json['longitude'];
    locationName = 'Panama';
  }
}
