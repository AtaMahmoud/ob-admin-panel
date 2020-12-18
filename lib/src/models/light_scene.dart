class LightScene {
  bool isDefault;
  String id;
  String source;
  String sceneName;
  List<Room> rooms;

  LightScene({
    this.isDefault,
    this.id,
    this.source,
    this.sceneName,
    this.rooms,
  });

  LightScene.fromJson(Map<String, dynamic> json) {
    isDefault = json['isDefault'];
    id = json['_id'];
    source = json['source'];
    sceneName = json['sceneName'];
    rooms = [];
    json['rooms'].forEach((e) => rooms.add(Room.fromJson(e)));
  }
}

class Room {
  List<Mode> modes;
  String id;
  String label;

  Room({
    this.modes,
    this.id,
    this.label,
  });

  Room.fromJson(Map<String, dynamic> json) {
    modes = [];
    json['moodes'].forEach((e) => modes.add(Mode.fromJson(e)));
    id = json['_id'];
    label = json['label'];
  }
}

class Mode {
  bool status;
  num intensity;
  String id;
  String lightName;
  String lightColor;

  Mode({
    this.status,
    this.intensity,
    this.id,
    this.lightName,
    this.lightColor,
  });

  Mode.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    intensity = json['intensity'];
    id = json['_id'];
    lightName = json['lightName'];
    lightColor = json['lightColor'];
  }
}
